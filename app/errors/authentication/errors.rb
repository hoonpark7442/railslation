module Authentication
  module Errors
    class Error < StandardError
    end

    class ProviderNotFound < Error
    end

    class ProviderNotEnabled < Error
    end

    # Raised when we find an email that's from a spammy domain.
    class SpammyEmailDomain < Error
    end
  end
end
