module Html
	class Parser
		attr_accessor :html

		def initialize(html)
			@html = html
		end

		def remove_nested_linebreak_in_list
			html_doc = Nokogiri::HTML(@html)

			html_doc.xpath("//*[self::ul or self::ol or self::li]/br").each(&:remove)

			@html = html_doc.to_html

			self
		end

		def add_contorl_class_to_codeblock
			doc = Nokogiri::HTML.fragment(@html)

			doc.search("div.highlight").each do |codeblock|
				codeblock.add_class("js-code-highlight")
			end

			@html = doc.to_html

			self
		end

		def wrap_all_tables
			doc = Nokogiri::HTML.fragment(@html)

			doc.search("table").each { |table| table.swap("<div class='table-wrapper-paragraph'>#{table}</div>") }

			@html = doc.to_html

			self
		end

		def remove_empty_paragraphs
			doc = Nokogiri::HTML.fragment(@html)

			doc.css("p").select { |paragraph| all_children_are_blank?(paragraph) }.each(&:remove)

			@html = doc.to_html

			self
		end

		def wrap_all_figures_with_tags
      html_doc = Nokogiri::HTML(@html)

      html_doc.xpath("//figcaption").each do |caption|
        next if caption.parent.name == "figure"
        next unless caption.previous_element

        fig = html_doc.create_element "figure"
        prev = caption.previous_element
        prev.replace(fig) << prev << caption
      end

      @html =
        if html_doc.at_css("body")
          html_doc.at_css("body").inner_html
        else
          html_doc.to_html
        end

      self
    end

		private

		def all_children_are_blank?(node)
			node.children.all? { |child| blank?(child) }
		end

		def blank?(node)
      (node.text? && node.content.strip == "") || (node.element? && node.name == "br")
    end
	end
end