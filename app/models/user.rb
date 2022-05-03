class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[kakao naver]

  USERNAME_MAX_LENGTH = 30
  USERNAME_REGEXP = /\A[a-zA-Z0-9_]+\z/

  has_many :social_auths, dependent: :delete_all
  has_many :articles, dependent: :destroy
  has_many :collections, dependent: :destroy

  validates :username, length: { in: 2..USERNAME_MAX_LENGTH }, format: USERNAME_REGEXP
  validates :username, uniqueness: {case_sensitive: false}

  before_validation :set_username

  def path
    "/#{username}"
  end

  def set_username
    self.username = username&.downcase
  end

  def admin?
    self.has_role? :admin
  end
end

