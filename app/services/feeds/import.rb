module Feeds
	class Import
		def initialize
			@authors_batch_size = 50
      @num_fetchers = 8
      @num_parsers = 4
      @earlier_than = 5.hours.ago
		end

		def self.call(...)
			new(...).call
		end

		def call
			authors.in_batches(of: authors_batch_size) do |batch_of_authors|
				feeds_per_author_id = fetch_feeds(batch_of_authors)

				feedjira_obj = parse_feeds(feeds_per_author_id)

				# 여기서부터는 순차적으로 db 입력한다. locking problem 피하기 위해.
				feedjira_obj.flat_map do |author_id, feeds|
					author = batch_of_authors.detect { |au| au.id == author_id }

					create_rss_feed(author, feeds)
				end

				batch_of_authors.update_all(feed_fetched_at: Time.current)
			end
		end

		private

		attr_reader :earlier_than, :authors_batch_size, :num_fetchers, :num_parsers

		def authors
			Author.where(feed_fetched_at: nil).or(Author.where(feed_fetched_at: ..earlier_than))
		end

		def fetch_feeds(batch_of_authors)
			data = batch_of_authors.pluck(:id, :feed_url)

			result = Parallel.map(data, in_threads: num_fetchers) do |author_id, feed_url|
				cleaned_url = feed_url.to_s.strip
				return if cleaned_url.blank?

				response = HTTParty.get(cleaned_url, timeout: 10)

				[author_id, response.body]
			rescue => e
				report_error(
          e,
          feeds_import_info: {
            author_id: author_id,
            feed_url: feed_url,
            error: "Feeds::Import::FetchFeedError"
          },
        )

        next
			end

			result.compact.to_h
		end

		def parse_feeds(feeds_per_author_id)
			result = Parallel.map(feeds_per_author_id, in_threads: num_fetchers) do |author_id, feed_xml|
				parsed_feed = Feedjira.parse(feed_xml)

				[author_id, parsed_feed]
			rescue => e
				report_error(
          e,
          feeds_import_info: {
            author_id: author_id,
            error: "Feeds::Import::ParseFeedError"
          },
        )

        next
			end

			result.compact.to_h
		end

		def create_rss_feed(author, feeds)
			feeds.entries.reverse_each do |item|
				next if Feeds::CheckItemPreviouslyCreated.call(item, author)

				Feeds::RssFeedCreator.call(item, author)
			rescue => e
				report_error(
          e,
          feeds_import_info: {
            author_id: author.id,
            error: "Feeds::Import::CreateRssFeedsError:#{item.url}"
          },
        )

        next
			end
		end

		def report_error(error, metadata)
			Rails.logger.error(
				"feeds::import::error::#{error.class}::#{metadata.merge(error_message: error.message)}",
			)
		end

	end
end

# https://brunch.co.kr/rss/@@JqQ
# https://medium.com/feed/@youngjin.kang