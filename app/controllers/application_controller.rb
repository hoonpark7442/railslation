class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pundit

  def not_found
    raise ActiveRecord::RecordNotFound, "Not Found"
  end

  def authenticate_user!
    if current_user
      return
    end
    respond_to do |format|
      format.html { redirect_to sign_up_path }
      format.json { render json: { error: "Please sign in" }, status: :unauthorized }
    end
  end

	private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username])
  end

  def user_not_authorized
    flash[:alert] = "해당 작업에 대한 권한이 없습니다."
    redirect_to(request.referrer || root_path)
  end
end
