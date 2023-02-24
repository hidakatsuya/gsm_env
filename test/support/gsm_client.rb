# frozen_string_literal: true

class GsmClient
  include GsmHelper

  def initialize(project_id:)
    @project_id = project_id

    @secrets = [
      gsm_secret(name: secret_path(project: @project_id, secret: 'A')),
      gsm_secret(name: secret_path(project: @project_id, secret: 'B')),
      gsm_secret(name: secret_path(project: @project_id, secret: 'C'))
    ]

    @secret_versions = [
      gsm_secret_version(
        name: secret_version_path(project: @project_id, secret: 'A', secret_version: 1),
        data: 'A data'
      ),
      gsm_secret_version(
        name: secret_version_path(project: @project_id, secret: 'B', secret_version: 2),
        data: 'B data'
      ),
      gsm_secret_version(
        name: secret_version_path(project: @project_id, secret: 'C', secret_version: 3),
        data: 'C data'
      )
    ]
  end

  def access_secret_version(name:)
    @secret_versions.find { |s_version|
      s_version.name.start_with?(name.delete_suffix('/versions/latest'))
    }
  end

  def list_secrets(*)
    @secrets
  end

  def project_path(*)
    super(project: @project_id)
  end
end

