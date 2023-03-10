# GsmEnv

[![Gem Version](https://badge.fury.io/rb/gsm_env.svg)](https://badge.fury.io/rb/gsm_env)
[![Test](https://github.com/hidakatsuya/gsm_env/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/hidakatsuya/gsm_env/actions/workflows/test.yml)

GsmEnv is a gem to set parameters obtained from GCP Secret Manager as environment variables, inspired by [aws-ssm-env gem](https://github.com/sonodar/aws-ssm-env-ruby).

## Prerequisites

### Supported Ruby Versions

2.7, 3.0, 3.1, 3.2

### Google Cloud

- [Authentication Settings](https://cloud.google.com/ruby/docs/reference/google-cloud-secret_manager/latest/AUTHENTICATION)
- Required Permissions: `secretmanager.secrets.list` and `secretmanager.versions.access`

#### FYI
- [Access a secret version](https://cloud.google.com/secret-manager/docs/access-secret-version)
- [List a secret's versions](https://cloud.google.com/secret-manager/docs/view-secret-version#list)
- [Cloud Build network](https://cloud.google.com/build/docs/build-config-file-schema#network)

## Installation

Install the gem and add to the application's Gemfile by executing:

    bundle add gsm_env

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install gsm_env

## Usage

```ruby
GsmEnv.load(project_id: "your-project-id")
```

Alternatively, you can omit the `project_id` by setting it to `GCP_PROJECT_ID` environment variable.

```ruby
ENV["GCP_PROJECT_ID"] = "your-project-id"

GsmEnv.load
```

### Filtering Secrets

```ruby
GsmEnv.load(filter: "labels.environment=production")
```

See https://cloud.google.com/secret-manager/docs/filtering for more details.

### Customizing Environment Assignment

```ruby
GsmEnv.load do |secret|
  ENV["DEVELOPMENT_#{secret.name}"] = secret.value
end
```

See [test/gsm_env_test.rb](https://github.com/hidakatsuya/gsm_env/blob/main/test/gsm_env_test.rb) for more details.

### Using with Rails

```ruby
# config/application.rb
if defined?(GsmEnv)
  GsmEnv.load(project_id: "your-project-id")
end
```

See also [hidakatsuya/shopping_list](https://github.com/hidakatsuya/shopping_list) for a reference of actual usage.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hidakatsuya/gsm_env. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hidakatsuya/gsm_env/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GsmEnv project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hidakatsuya/gsm_env/blob/main/CODE_OF_CONDUCT.md).
