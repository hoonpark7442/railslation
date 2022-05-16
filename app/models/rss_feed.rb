class RssFeed < ApplicationRecord
  has_one :translated_article, class_name: "Article", dependent: :nullify
  belongs_to :author

  validates :title, presence: true
  validates :feed_source_url, presence: true
end
