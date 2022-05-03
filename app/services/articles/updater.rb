module Articles
	class Updater
		def initialize(user, article, article_params)
			@user = user
			@article = article
      @article_params = article_params
		end

		def self.call(...)
			new(...).call
		end

		def call
			success = article.update(article_params)
		end

		private

    attr_reader :user, :article, :article_params
	end
end