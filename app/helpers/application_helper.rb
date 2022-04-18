module ApplicationHelper

	def site_name
    @site_name ||= Settings::General.site_name
  end

  def user_logged_in_status
    user_signed_in? ? "logged-in" : "logged-out"
  end
end
