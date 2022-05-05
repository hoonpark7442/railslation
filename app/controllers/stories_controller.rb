class StoriesController < ApplicationController
  def index
    @page = (params[:page] || 1).to_i
    @article_index = true

    handle_base_index
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

  def handle_base_index
    @home_page = true
    assign_feed_stories

    @article_index = true

    render template: "articles/index"
  end

  def assign_feed_stories
    # rss feed인지 article feed인지 구분해서 쏴줘야 한다.
    # if params[:feed_type] == "rss_feed"
    # else
    # end
    @default_home_feed = true

    feed = Articles::Feeds::ArticleFeed.new(page: @page)

    @stories = feed.default_home_feed

    @pinned_article = pinned_article&.decorate

    @stories = ArticleDecorator.decorate_collection(@stories)
  end

  def pinned_article
    @pinned_article ||= PinnedArticle.get
  end
end
