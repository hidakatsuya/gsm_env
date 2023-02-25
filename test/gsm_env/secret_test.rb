# frozen_string_literal: true

require 'test_helper'

class GsmEnv::SecretTest < Test::Unit::TestCase
  include GsmHelper

  setup do
    secret_paths = { project: '123', secret: 'ABC' }

    @g_secret = gsm_secret(
      name: secret_path(**secret_paths)
    )
    @g_secret_version = gsm_secret_version(
      name: secret_version_path(**secret_paths, secret_version: 9),
      data: 'DATA'
    )
  end

  test 'attributes' do
    @secret = GsmEnv::Secret.new(@g_secret, @g_secret_version)

    assert_equal 'ABC', @secret.name
    assert_equal 'DATA', @secret.value
    assert_equal @g_secret, @secret.secret
    assert_equal @g_secret_version, @secret.version
  end

  test '#name raises an error when secret name could not be obtained correctly' do
    @g_secret.name = 'invalid resource name'
    assert_raises GsmEnv::Secret::InvalidName do
      GsmEnv::Secret.new(@g_secret, @g_secret_version).name
    end

    @g_secret.name = 'projects/123/secrets/ABC/versions/1'
    assert_raises GsmEnv::Secret::InvalidName do
      assert_nil GsmEnv::Secret.new(@g_secret, @g_secret_version).name
    end
  end
end
