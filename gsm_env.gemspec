# frozen_string_literal: true

require_relative 'lib/gsm_env/version'

Gem::Specification.new do |spec|
  spec.name = 'gsm_env'
  spec.version = GsmEnv::VERSION
  spec.authors = ['Katsuya Hidaka']
  spec.email = ['hidakatsuya@gmail.com']

  spec.summary = 'A gem to set parameters obtained from GCP Secret Manager as environment variables.'
  spec.description = spec.summary
  spec.homepage = 'https://github.com/hidakatsuya/gsm_env'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hidakatsuya/gsm_env'
  spec.metadata['changelog_uri'] = 'https://github.com/hidakatsuya/gsm_env/releases'

  spec.require_paths = ['lib']
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split('\x0').reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.add_dependency 'google-cloud-secret_manager', '>= 1.2.0', '< 2.0.0'
end
