class Author < ApplicationRecord
	enum author_type: { individual_author: 1, company_author: 2 }
	enum nationality: { korean: 1, eng: 2, jp: 3 }

	has_many :rss_feeds, dependent: :destroy

	validates :feed_url, uniqueness: true
	validates :website_url, uniqueness: true
end
