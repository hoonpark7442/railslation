class ArticleDecorator < ApplicationDecorator

  LONG_MARKDOWN_THRESHOLD = 1000

  def current_state_path
    published ? "/#{user_username}/#{slug}" : "/#{user_username}/#{slug}?preview=#{password}"
  end

  def title_length_classification
    if title.size > 105
      "longest"
    elsif title.size > 80
      "longer"
    elsif title.size > 60
      "long"
    elsif title.size > 22
      "medium"
    else
      "short"
    end
  end

  def cached_tag_list_array
    (cached_tag_list || "").split(", ")
  end

  def long_markdown?
    body_markdown.present? && body_markdown.size > LONG_MARKDOWN_THRESHOLD
  end

  def published_at_int
    published_at.to_i
  end
end