module Articles
  class Creator
    def initialize(user, article_params)
      @user = user
      @article_params = article_params
    end

    def self.call(...)
      new(...).call
    end

    def call
      article = save_article

      # if article.persisted?
      #   # Subscribe author to notifications for all comments on their article.
      #   NotificationSubscription.create(user: user, notifiable_id: article.id, notifiable_type: "Article",
      #                                   config: "all_comments")
      # end

      article
    end

    private

    attr_reader :user, :article_params

    def save_article
      series = article_params[:series]
      tags = article_params[:tags]

      # convert tags from array to a string
      if tags.present?
        article_params.delete(:tags)
        article_params[:tag_list] = tags.join(", ")
      end

      article = Article.new(article_params)
      article.user_id = user.id
      article.collection = Collection.find_series(series, user) if series.present?
      article.save
      article
    end
  end
end
