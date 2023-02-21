# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'gsm_env'
require 'test/unit'
require 'test/unit/rr'
require 'hashie'

module GsmHelper
  def gsm_secret(name: nil)
    Hashie::Mash.new(
      name: name || gsm_secret_path,
      create_time: 'Google::Protobuf::Timestamp',
      labels: { env: 'production' },
      topics: [],
      etag: 'x' * 14,
      version_aliases: {},
      annotations: {}
    )
  end

  def gsm_secret_version(name: nil, data: nil)
    Hashie::Mash.new(
      name: name || gsm_secret_version_path,
      payload: { data: "#{data || 'abc123'}\n" }
    )
  end

  def gsm_project_path(project_id: '0' * 12)
    "projects/#{project_id}"
  end

  def gsm_secret_path(project_id: '0' * 12, secret_id: 'TEST_ENV')
    "projects/#{project_id}/secrets/#{secret_id}"
  end

  def gsm_secret_version_path(project_id: '0' * 12, secret_id: 'TEST_ENV', version: 1)
    g_secret_path = gsm_secret_path(project_id: project_id, secret_id: secret_id)
    "#{g_secret_path}/versions/#{version}"
  end
end

class GsmClient
  include GsmHelper

  def initialize(project_id:)
    @project_id = project_id

    @secrets = [
      gsm_secret(name: gsm_secret_path(project_id: @project_id, secret_id: 'A')),
      gsm_secret(name: gsm_secret_path(project_id: @project_id, secret_id: 'B')),
      gsm_secret(name: gsm_secret_path(project_id: @project_id, secret_id: 'C'))
    ]

    @secret_versions = [
      gsm_secret_version(
        name: gsm_secret_version_path(project_id: @project_id, secret_id: 'A', version: 1),
        data: 'A data'
      ),
      gsm_secret_version(
        name: gsm_secret_version_path(project_id: @project_id, secret_id: 'B', version: 2),
        data: 'B data'
      ),
      gsm_secret_version(
        name: gsm_secret_version_path(project_id: @project_id, secret_id: 'C', version: 3),
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
    gsm_project_path(project_id: @project_id)
  end
end
