# frozen_string_literal: true

module GsmEnv
  class Secret
    class InvalidName < StandardError; end

    attr_reader :secret, :version

    def initialize(secret, version)
      @secret = secret
      @version = version
    end

    def name
      @name ||= extract_secret_name_from(secret.name)
    end

    def value
      version.payload.data&.chomp
    end

    private

    SECRET_RESOURCE_NAME_REGEXP = %r{^projects/.+/secrets/(?<secret>[^/]+)$}

    def extract_secret_name_from(secret_resource_name)
      match = SECRET_RESOURCE_NAME_REGEXP.match(secret_resource_name)

      raise InvalidName unless match && match["secret"]

      match["secret"]
    end
  end
end
