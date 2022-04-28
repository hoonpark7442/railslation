module MarkdownProcessor
	class Parser
		WORDS_READ_PER_MINUTE = 250.0

		def initialize(content, source: nil, user: nil)
			@content = content
			@source = source
			@user = user
		end

		def finalize(link_attributes: {})
      options = { hard_wrap: true, filter_html: true, link_attributes: link_attributes }
      renderer = Redcarpet::Render::HTMLRouge.new(options)
      markdown = Redcarpet::Markdown.new(renderer, Constants::Redcarpet::CONFIG)

      html = markdown.render(@content)

      parse_html(html)
    end

		def calculate_reading_time
      word_count = @content.split(/[^A-Za-z0-9가-힣+]/).count
      (word_count / WORDS_READ_PER_MINUTE).ceil
    end

    private

    def parse_html(html)
    	return html if html.blank?

    	Html::Parser.new(html)
    							.remove_nested_linebreak_in_list
    							.add_contorl_class_to_codeblock
    							.wrap_all_tables
    							.remove_empty_paragraphs
    							.wrap_all_figures_with_tags
    							.html
    end
	end
end