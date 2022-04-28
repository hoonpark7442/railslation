class Collection < ApplicationRecord
  belongs_to :user

  has_many :articles, dependent: :nullify

  validates :slug, presence: true, uniqueness: { scope: :user_id }

  def self.find_series(slug, user)
    Collection.find_or_create_by(slug: slug, user: user)
  end
end
