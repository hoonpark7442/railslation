class Article < ApplicationRecord
	acts_as_taggable_on :tags

	belongs_to :user
	belongs_to :collection, optional: true

	counter_culture :user

	validates :body_markdown, length: { minimum: 0, allow_nil: false }
  validates :body_markdown, uniqueness: { scope: %i[user_id title] }
  # validates :slug, uniqueness: { scope: :user_id }
  validates :title, presence: true, length: { maximum: 128 }

  # before_validation :evaluate_markdown, :create_slug
  before_validation :evaluate_markdown

  private

  def evaluate_markdown
  	parsed = FrontMatterParser::Parser.new(:md).call(body_markdown)

  	parsed_markdown = MarkdownProcessor::Parser.new(parsed.content, source: self, user: user)

  	self.reading_time = parsed_markdown.calculate_reading_time
  	self.processed_html = parsed_markdown.finalize

  	evaluate_frontmatter(parsed.front_matter)
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
end
