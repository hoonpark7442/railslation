module Articles
	module Feeds
		class RssFeed
			def initialize(author: nil, number_of_feeds: Article::DEFAULT_FEED_PAGINATION_WINDOW_SIZE, page: 1, tag: nil)
				@author = author
				@number_of_feeds = number_of_feeds
				@page = page
				@tag = tag
			end

			def default_home_feed
				::RssFeed.page(@page).per(@number_of_feeds)
            	 .order(published_at: :desc)
			end
		end
	end
end