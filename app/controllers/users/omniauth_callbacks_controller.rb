# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  OMNIAUTH_SNS_LIST = %i[kakao naver].freeze

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = Users::SocialAuthService.new(request.env["omniauth.auth"]).call

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end
 
  OMNIAUTH_SNS_LIST.each do |provider|
    provides_callback_for provider
  end

  private

  def omniauth_params
    request.env['omniauth.auth'].to_h
  end

end
