module Authentication
  # These are meant to be called from the specific providers
  module Paths
    # Returns the authentication path for the given provider
    def self.authentication_path(provider_name)
      Rails.application.routes.url_helpers.public_send(
        "user_#{provider_name}_omniauth_authorize_path"
      )
    end
  end
end
