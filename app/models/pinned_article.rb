class PinnedArticle

	class << self
		def get
			return unless valid?

			Article.published.find(feed_pinned_article_id)
		end

		private

		def feed_pinned_article_id
			Settings::General.feed_pinned_article_id
		end

		def setting
			Settings::General.find_by(var: :feed_pinned_article_id)
		end

		def valid?
			setting&.valid?
		end
	end

end