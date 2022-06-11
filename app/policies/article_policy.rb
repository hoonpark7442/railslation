class ArticlePolicy < ApplicationPolicy
	def update?
    user_admin?
  end
end