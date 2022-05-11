module Homepage
	class ArticlesQuery
		def initialize(user_id: nil)
			@relation = Article.published.feed_column_select
			@user_id = user_id
		end

		def self.call(...)
			new(...).call
		end

		def call
			@relation
		end
	end
end