# frozen_string_literal: true

require_relative "gsm_env/version"
require_relative "gsm_env/loader"

module GsmEnv
  def self.load(project_id: nil, filter: nil, &assigner)
    loader = Loader.new(
      project_id: project_id || ENV["GCP_PROJECT_ID"],
      filter: filter
    )
    secrets = loader.load

    assigner ||= lambda { |secret|
      ENV[secret.name] = secret.value
    }
    secrets.each(&assigner)
  end
end
