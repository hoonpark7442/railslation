class ExistingPublishedArticleIdValidator < ActiveModel::EachValidator
	DEFAULT_MSG = "반드시 유효하며 published된 아티클 id 여야 합니다."

	def validate_each(record, attribute, value)
		return if Article.published.exists?(id: value)

		record.errors.add(attribute, DEFAULT_MSG)
	end
end