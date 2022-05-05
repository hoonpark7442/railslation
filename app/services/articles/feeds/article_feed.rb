module Articles
	module Feeds
		class ArticleFeed
			def initialize(user: nil, number_of_articles: Article::DEFAULT_FEED_PAGINATION_WINDOW_SIZE, page: 1, tag: nil)
				@user = user
				@number_of_articles = number_of_articles
				@page = page
				@tag = tag
			end

			def default_home_feed
				Article.published.feed_column_select
            	 .page(@page).per(@number_of_articles)
            	 .order(featured_number: :desc)
			end
		end
	end
end