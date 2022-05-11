module Search
	class Article
		def self.search_documents(term: nil, user_id: nil)
			return [] unless term.present?

			relation = Homepage::ArticlesQuery.call

			search_results = relation.search_articles(term)
		end
	end
end