class StoriesController < ApplicationController
  def index
  end

  def show
    @story_show = true
    handle_article_show
  end

  private

  def handle_article_show
    path = "/#{params[:username].downcase}/#{params[:slug]}"
    @article = Article.includes(:user).find_by(path: path)&.decorate

    assign_article_show_variables
    return if performed?

    render template: "articles/show"
  end

  def assign_article_show_variables
    not_found if @article.nil?
    not_found unless @article.user

    @article_show = true
    @user = @article.user

    if @article.collection
      @collection = @article.collection

      @collection_articles = @article.collection.articles.published
                                                         .order(:published_at)
    end

  end
end
