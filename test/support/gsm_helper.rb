# frozen_string_literal: true

require 'google/cloud/secret_manager/v1/secret_manager_service/paths'

module GsmHelper
  include ::Google::Cloud::SecretManager::V1::SecretManagerService::Paths

  def gsm_secret(name:)
    Hashie::Mash.new(
      name: name,
      create_time: 'Google::Protobuf::Timestamp',
      labels: { env: 'production' },
      topics: [],
      etag: 'x' * 14,
      version_aliases: {},
      annotations: {}
    )
  end

  def gsm_secret_version(name:, data:)
    Hashie::Mash.new(
      name: name,
      payload: { data: "#{data}\n" }
    )
  end
end
