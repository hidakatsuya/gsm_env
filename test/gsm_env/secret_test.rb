# frozen_string_literal: true

require 'test_helper'

class GsmEnv::SecretTest < Test::Unit::TestCase
  include GsmHelper

  test 'accessors' do
    g_secret = gsm_secret
    g_secret_version = gsm_secret_version

    secret = GsmEnv::Secret.new(g_secret, g_secret_version)

    assert_equal 'TEST_ENV', secret.name
    assert_equal 'abc123', secret.value
    assert_equal g_secret, secret.secret
    assert_equal g_secret_version, secret.version
  end
end
