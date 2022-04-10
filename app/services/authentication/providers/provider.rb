module Authentication
  module Providers
    # Authentication provider
    class Provider

      def initialize(auth_payload)
        @auth_payload = cleanup_payload(auth_payload.dup)
        @info = auth_payload.info
        @raw_info = auth_payload.extra.raw_info
      end

      def name
        auth_payload.provider
      end

      def payload
        auth_payload
      end

      def self.provider_name
        name.demodulize.downcase.to_sym
      end

      def self.official_name
        name.demodulize
      end

      def self.authentication_path
        ::Authentication::Paths.authentication_path(provider_name)
      end

      protected

      # Remove sensible data from the payload
      def cleanup_payload(_auth_payload)
        raise SubclassResponsibility
      end

      attr_reader :auth_payload, :info, :raw_info
    end
  end
end
