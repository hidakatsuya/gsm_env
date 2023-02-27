# frozen_string_literal: true

require "test_helper"

class GsmEnvTest < Test::Unit::TestCase
  setup do
    client = GsmClient.new(project_id: "123")
    stub(Google::Cloud::SecretManager).secret_manager_service { client }
  end

  test ".load(project_id: '123', filter: 'labels.env=production')" do
    mock.proxy(GsmEnv::Loader).new(project_id: "123", filter: "labels.env=production")

    GsmEnv.load(project_id: "123", filter: "labels.env=production")

    assert_equal "A data", ENV["A"]
    assert_equal "B data", ENV["B"]
    assert_equal "C data", ENV["C"]
  end

  test ".load() with GCP_PROJECT_ID" do
    ENV["GCP_PROJECT_ID"] = "123"
    mock.proxy(GsmEnv::Loader).new(project_id: "123", filter: nil)

    GsmEnv.load

    assert_equal "A data", ENV["A"]
    assert_equal "B data", ENV["B"]
    assert_equal "C data", ENV["C"]
  end

  test ".load(project_id: '123') { |secret| ... }" do
    GsmEnv.load(project_id: "123") do |secret|
      ENV["DEV_#{secret.name}"] = secret.value
    end

    assert_equal "A data", ENV["DEV_A"]
    assert_equal "B data", ENV["DEV_B"]
    assert_equal "C data", ENV["DEV_C"]
  end
end
