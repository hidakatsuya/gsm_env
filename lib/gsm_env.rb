# frozen_string_literal: true

require_relative 'gsm_env/version'
require_relative 'gsm_env/secret'
require_relative 'gsm_env/loader'
require_relative 'gsm_env/assigner'

module GsmEnv
  def self.load(project_id: nil, filter: nil, assigner: nil)
    loader = Loader.new(
      project_id: project_id || ENV['GOOGLE_PROJECT_ID'],
      filter: filter
    )
    secrets = loader.load

    assigner ||= Assigner.new
    assigner.assign(secrets)

    nil
  end
end
