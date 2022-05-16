module Feeds
	class CheckItemPreviouslyCreated
		def initialize(item, author)
			@item = item
			@author = author
		end

		def self.call(...)
			new(...).call
		end

		def call
			title = item.title.strip
			feed_source_url = item.url.strip.split("?source=")[0]
			
			author.rss_feeds.where(title: title).or(author.rss_feeds.where(feed_source_url: feed_source_url)).exists?
		end

		private

		attr_reader :item, :author
	end
end