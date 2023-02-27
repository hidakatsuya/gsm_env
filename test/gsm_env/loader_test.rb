# frozen_string_literal: true

require "test_helper"

class GsmEnv::LoaderTest < Test::Unit::TestCase
  setup do
    @project_id = "123"
    @client = GsmClient.new(project_id: @project_id)

    stub(Google::Cloud::SecretManager).secret_manager_service { @client }

    @loader = GsmEnv::Loader.new(project_id: @project_id, filter: "filter")
  end

  test "initializing" do
    assert_equal @client, @loader.send(:client)
    assert_equal @project_id, @loader.send(:project_id)
    assert_equal "filter", @loader.send(:filter)
  end

  test "#load" do
    secrets = @loader.load

    assert_equal 3, secrets.size

    secrets[0].then do |s|
      assert_equal "A", s.name
      assert_equal "A data", s.value
    end

    secrets[1].then do |s|
      assert_equal "B", s.name
      assert_equal "B data", s.value
    end

    secrets[2].then do |s|
      assert_equal "C", s.name
      assert_equal "C data", s.value
    end
  end
end
