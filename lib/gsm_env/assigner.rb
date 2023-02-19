# frozen_string_literal: true

module GsmEnv
  class Assigner
    def assign(secrets)
      secrets.each do |secret|
        ENV[secret.name] = secret.value
      end
    end
  end
end
