Rails.application.config.middleware.use OmniAuth::Builder do
  provider :kakao, "4b2cfea758fab65a0b14e9c3469fe522", { :redirect_path => "/users/auth/kakao/callback" }
end
