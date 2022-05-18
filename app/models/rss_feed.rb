class RssFeed < ApplicationRecord
  has_one :translated_article, class_name: "Article", dependent: :nullify
  belongs_to :author

  delegate :name, to: :author, prefix: true

  validates :title, presence: true
  validates :feed_source_url, presence: true

  before_save :set_caches

  def published_timestamp
    return "" unless published_at

    published_at.utc.in_time_zone("Seoul")
  end

  def readable_publish_date
    relevant_date = published_timestamp

    if relevant_date && relevant_date.year == Time.current.year
      relevant_date&.strftime("%-m월 %-d일")
    else
      relevant_date&.strftime("%y년 %-m월 %-d일")
    end
  end

  def translated?
    translated
  end

  def self.find_rss_feed(id)
    RssFeed.find_by(id: id)
  end

  private

  def set_caches
    return unless author

    self.cached_author_name = author_name
  end
end
