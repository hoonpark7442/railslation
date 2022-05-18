class StoriesController < ApplicationController
  def index
    @page = (params[:page] || 1).to_i

    # return handle_rss_index if params.has_key?(:feed_type) && params[:feed_type] == 'rss_feed'

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

    if @article.rss_feed
      @rss_feed = @article.rss_feed
    end
  end

  def handle_base_index
    @home_page = true
    assign_feed_stories

    render template: "articles/index"
  end

  def assign_feed_stories
    if params.has_key?(:feed_type) && params[:feed_type] == 'rss_feed'
      assign_rss_feed_stories
    else
      assign_article_feed_stories
      assign_latest_rss_feed
    end

    @stories = @feed.default_home_feed

    decorator_name = decorator_class(@stories)

    @stories = decorator_name.decorate_collection(@stories)
  end

  def assign_rss_feed_stories
    @feed = Articles::Feeds::RssFeed.new(page: @page)
    @rss_feed_index = true
  end

  def assign_article_feed_stories
    @feed = Articles::Feeds::ArticleFeed.new(page: @page)
    @pinned_article = pinned_article&.decorate
  end

  def assign_latest_rss_feed
    @latest_rss_feeds = RssFeed.includes(:translated_article)
                               .order(translated: :desc, published_at: :desc, created_at: :desc)
                               .limit(5)
  end

  def pinned_article
    @pinned_article ||= PinnedArticle.get
  end

  # application_record에도 중복된 코드가 있다. 리팩토링 필요
  def decorator_class(stories)
    prefix = stories.first.class.name
    decorator_name = "#{prefix}Decorator"
    decorator_name_constant = decorator_name.safe_constantize
    
    return decorator_name_constant unless decorator_name_constant.nil?
  end
end
