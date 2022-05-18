module Articles
	class Builder
		def initialize(user)
			@user = user
		end

		def self.call(...)
			new(...).call
		end

		def call
			build_article
		end

		private

		attr_reader :user

		def build_article
			body_markdown = "---\ntitle: \npublished: false\ndescription: " \
             "\ntags: \nseries: \ntranslation: \n---\n\n"

      Article.new(
      	body_markdown: body_markdown,
      	processed_html: "",
      	user_id: user&.id
      )
		end
	end
end