module Settings
  class General < Base
    self.table_name = :site_configs

    # Core setup
    # setting :app_domain, type: :string, default: ApplicationConfig["APP_DOMAIN"]

    # API Tokens
    # setting :health_check_token, type: :string
  
    # Broadcast
    setting :welcome_notifications_live_at, type: :date

    # core
    setting :site_name, type: :string

    # Feed
    # setting :feed_pinned_article_id, type: :integer, validates: {
    #   existing_published_article_id: true, allow_nil: true
    # }
  end
end
