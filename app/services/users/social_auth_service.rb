module Users
  class SocialAuthService
    def initialize(params)
      @provider = params["provider"]
      @params = params
    end

    def self.call(...)
      new(...).call
    end

    def call
      social_auth = SocialAuth.where(provider: @provider, uid: @params["uid"]).first_or_create do |auth|
        auth.provider = @params["provider"]
        auth.uid = @params["uid"]
        auth.email = @params["info"]["email"]
        auth.image = auth_image
    
        link_user(auth)
      end

      social_auth.user
    end

    private

    attr_reader :provider, :params

    def auth_image
      if provider == 'kakao'
        params["extra"]["properties"]["profile_image"]
      elsif provider == 'naver'
        params["info"]["image"]
      else
        nil
      end
    end

    def link_user(auth)
      return if auth.user_id.present?

      user = User.find_or_create_by(email: auth.email) do |usr|
        usr.email = auth.email
        usr.name = params["info"]["name"]
        usr.password = Devise.friendly_token[0, 20]
      end

      auth.user = user
    end

  end
end