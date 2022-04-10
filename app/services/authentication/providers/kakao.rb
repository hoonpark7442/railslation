module Authentication
  module Providers
    # Kakao authentication provider, uses omniauth-kakao as backend
    class Kakao < Provider
      OFFICIAL_NAME = "Kakao".freeze

      # def new_user_data
      #   name = raw_info.name.presence || info.name

      #   {
      #     email: info.email.to_s,
      #     github_username: info.nickname,
      #     name: name,
      #     remote_profile_image_url: Users::SafeRemoteProfileImageUrl.call(info.image.to_s)
      #   }
      # end

      def self.official_name
        OFFICIAL_NAME
      end

      def self.sign_in_path(**kwargs)
        ::Authentication::Paths.sign_in_path(
          provider_name,
          **kwargs,
        )
      end

      protected

      def cleanup_payload(auth_payload)
        auth_payload
      end
    end
  end
end
