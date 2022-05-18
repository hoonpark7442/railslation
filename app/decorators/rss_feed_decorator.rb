class RssFeedDecorator < ApplicationDecorator

  def cached_tag_list_array
    (cached_tag_list || "").split(", ")
  end

  def published_at_int
    published_at.to_i
  end
end