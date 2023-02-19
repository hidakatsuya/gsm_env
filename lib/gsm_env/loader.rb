# frozen_string_literal: true

require 'google/cloud/secret_manager'

module GsmEnv
  class Loader
    def initialize(project_id: nil, filter: nil)
      @project_id = project_id
      @filter = filter
      @client = Google::Cloud::SecretManager.secret_manager_service
    end

    def load
      secrets.map do |secret|
        version = client.access_secret_version(name: "#{secret.name}/versions/latest")
        Secret.new(secret, version)
      end
    end

    private

    attr_reader :project_id, :client, :filter

    def secrets
      client.list_secrets(parent: project_path, filter: filter)
    end

    def project_path
      client.project_path(project: project_id)
    end
  end
end
