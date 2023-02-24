# frozen_string_literal: true

require 'test_helper'

class GsmEnv::SecretTest < Test::Unit::TestCase
  include GsmHelper

  test 'accessors' do
    secret_path = { project_id: '123', secret_id: 'ABC' }

    g_secret = gsm_secret(
      name: gsm_secret_path(**secret_path)
    )
    g_secret_version = gsm_secret_version(
      name: gsm_secret_version_path(**secret_path, version: 9),
      data: 'DATA'
    )

    secret = GsmEnv::Secret.new(g_secret, g_secret_version)

    assert_equal 'ABC', secret.name
    assert_equal 'DATA', secret.value
    assert_equal g_secret, secret.secret
    assert_equal g_secret_version, secret.version
  end
end
