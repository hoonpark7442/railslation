module Feeds
	class RssFeedCreator
		def initialize(feed, author)
			@feed = feed
			@author = author
			@title = feed.title.strip
			@categories = feed.categories || []
		end

		def self.call(...)
			new(...).call
		end

		def call
			RssFeed.create!(
				author_id: author.id,
				title: processed_title,
				feed_source_url: feed.url.strip.split("?source=")[0],
				published_at: feed.published&.to_date || Time.current,
				cached_tag_list: get_tags
			)
		end

		private

		attr_reader :feed, :author, :title, :categories

		def processed_title
			title.truncate(128, omission: "...", separator: " ")
		end

		def get_tags
			categories.first(4).map do |tag|
				tag.delete(" ")
			end.join(",")
		end
	end
end