module ApplicationHelper
  ENOUGH_RSS_FEED_THRESHOLD = 100

	def site_name
    @site_name ||= Settings::General.site_name
  end

  def user_logged_in_status
    user_signed_in? ? "logged-in" : "logged-out"
  end

  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks, :lax_html_blocks, :lax_spacing, :strikethrough, :superscript, :tables, :footnotes]
    Markdown.new(text, *options).to_html.html_safe
  end

  def render_tag_list(tag)
    safe_join([content_tag(:span, "#", class: "crayons-tag__prefix"), tag])
  end

  def view_class
    if @story_show
      "stories stories-show"
    else
      "#{controller_name} #{controller_name}-#{controller.action_name}"
    end
  end

  def current_page
    "#{controller_name}-#{controller.action_name}"
  end

  def collection_header(collection)
    size_str = "#{collection.articles.published.size} 개의 시리즈"
    body_str = collection.slug.present? ? "#{collection.slug} (#{size_str})" : size_str

    body_str
  end

  def adjusted_cache_key(path)
    "#{path}-#{Time.current.to_s}"
  end

  def estimated_rss_feeds_count
    RssFeed.estimated_count
  end

  def display_rss_feed_count?
    estimated_rss_feeds_count > ENOUGH_RSS_FEED_THRESHOLD
  end
end