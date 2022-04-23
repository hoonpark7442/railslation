module ApplicationHelper

	def site_name
    @site_name ||= Settings::General.site_name
  end

  def user_logged_in_status
    user_signed_in? ? "logged-in" : "logged-out"
  end

  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks, :lax_html_blocks, :lax_spacing, :strikethrough, :superscript, :tables, :footnotes]
    Markdown.new(text, *options).to_html.html_safe
  end

end