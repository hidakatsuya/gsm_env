# frozen_string_literal: true

module GsmEnv
  Secret = Struct.new(:secret, :version) do
    def name
      @name ||= secret.name.split('/').fetch(3)
    end

    def value
      version.payload.data&.chomp
    end
  end
end
