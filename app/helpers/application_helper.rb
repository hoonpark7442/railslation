module ApplicationHelper

	def site_name
    @site_name ||= Settings::General.site_name
  end


end
