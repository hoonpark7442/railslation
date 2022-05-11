class Article < ApplicationRecord
  include PgSearch::Model

  DEFAULT_FEED_PAGINATION_WINDOW_SIZE = 50

	acts_as_taggable_on :tags

	belongs_to :user
	belongs_to :collection, optional: true

	delegate :name, to: :user, prefix: true
	delegate :username, to: :user, prefix: true

	counter_culture :user

	validates :body_markdown, length: { minimum: 0, allow_nil: false }
  validates :body_markdown, uniqueness: { scope: %i[user_id title] }
  validates :slug, presence: { if: :published? }
  validates :slug, uniqueness: { scope: :user_id }
  validates :title, presence: true, length: { maximum: 128 }
  validates :user_id, presence: true

  before_validation :evaluate_markdown, :create_slug

  before_save :update_cached_user
  before_save :set_numbers
  before_save :set_base_score
  before_save :set_caches
  before_create :set_password

  after_commit :touch_collection

  scope :published, -> {
  	where(published: true)
  	.where("published_at <= ?", Time.current)
  }

  scope :feed_column_select, -> {
    select(:id, :cached_user, :cached_tag_list, :description, :path, :published,
           :published_at, :slug, :title, :user_id, :updated_at, :reading_time, :cached_user_username)
  }

  # postgres trigger 기능을 사용하여 vector 컬럼에 데이터 삽입
  trigger.name(:update_reading_list_document).before(:insert, :update).for_each(:row) do
    <<~SQL
      NEW.reading_list_document := 
        setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.title, ''))), 'A') ||
        setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_tag_list, ''))), 'B') ||
        setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.body_markdown, ''))), 'C') ||
        setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_user_name, ''))), 'D') ||
        setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_user_username, ''))), 'D');
    SQL
  end

  pg_search_scope :search_articles,
                  against: :reading_list_document,
                  using: {
                    tsearch: { 
                      prefix: true,
                      tsvector_column: :reading_list_document
                    }
                  },
                  ignoring: :accents

  def published_timestamp
    return "" unless published
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

  private

  def evaluate_markdown
  	parsed = FrontMatterParser::Parser.new(:md).call(body_markdown)

  	parsed_markdown = MarkdownProcessor::Parser.new(parsed.content, source: self, user: user)

  	self.reading_time = parsed_markdown.calculate_reading_time
  	self.processed_html = parsed_markdown.finalize

  	evaluate_frontmatter(parsed.front_matter)
  end

  def create_slug
  	if slug.blank? && title.present? && !published
  		self.slug = title_to_slug + "-temp-slug-#{rand(10_000)}"
  	elsif should_generate_final_slug?
  		self.slug = title_to_slug
  	end
  end

  def evaluate_frontmatter(front_matter)
  	self.title = front_matter["title"] if front_matter["title"].present?
  	set_tag_list(front_matter["tags"]) if front_matter["tags"].present?
  	self.published = front_matter["published"] if %[true false].include?(front_matter["published"].to_s)
  	self.published_at = Time.current if published
  	self.description = front_matter["description"] if front_matter["description"].present?
  	self.collection_id = Collection.find_series(front_matter["series"], user).id if front_matter["series"].present?
  end

  def set_tag_list(tags)
  	self.tag_list = []

  	tag_list.add(tags, parse: true)
  end

  def title_to_slug
  	"#{Sterile.sluggerize(title)}-#{rand(100_000).to_s(26)}"
  end

  def should_generate_final_slug?
  	(title && published && slug.blank?) || (title && published && slug.include?("-temp-slug-"))
  end

  def update_cached_user
  	self.cached_user = user ? Articles::CachedEntity.from_object(user) : nil
  end

  def set_numbers
  	self.featured_number = Time.current.to_i if featured_number.blank? && published
  	set_nth_published_by_author
  end

  def set_nth_published_by_author
  	return unless nth_published_by_author.zero? && published

  	# devto 코드는 index로 체크하는 거지만 벤치마킹 결과 그냥 size로 하는게 더 빠르다
  	self.nth_published_by_author = user.articles.published.ids.size + 1
  end

  def set_base_score
  	self.hotness_score = 1000 if hotness_score.blank?
  end

  def set_caches
  	return unless user

  	self.cached_user_name = user_name
  	self.cached_user_username = user_username
  	self.path = calculated_path.downcase
  end

  def calculated_path
  	"/#{user_username}/#{slug}"
  end

  def set_password
  	return if password.present?

  	self.password = SecureRandom.hex(60)
  end

  def touch_collection
  	collection.touch if collection && previous_changes.present?
  end
end
