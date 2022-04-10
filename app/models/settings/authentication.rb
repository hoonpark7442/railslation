module Settings
  class Authentication < Base
    self.table_name = :settings_authentications

    setting :providers, type: :array, default: %w[]
    
    # @param domain [String] The domain to check for acceptability
    #
    # @return [Boolean] do we allow this domain?
    def self.acceptable_domain?(domain:)
      return false if blocked_registration_email_domains.include?(domain)
      return true if allowed_registration_email_domains.empty?
      return true if allowed_registration_email_domains.include?(domain)

      false
    end
  end
end
