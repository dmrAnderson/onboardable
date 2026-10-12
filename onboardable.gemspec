# frozen_string_literal: true

require_relative 'lib/onboardable/version'

Gem::Specification.new do |spec|
  spec.name = 'onboardable'
  spec.version = Onboardable::VERSION
  spec.authors = ['Artem Skrynnyk']
  spec.email = ['skrynnyk.artem@coaxsoft.com']

  spec.summary = 'Streamlines onboarding process integration'
  spec.description = 'Provides tools for easy setup of custom onboarding to boost engagement.'
  spec.homepage = 'https://github.com/dmrAnderson/onboardable'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.3.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/dmrAnderson/onboardable/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/dmrAnderson/onboardable/issues'
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/onboardable'

  spec.files = Dir['lib/**/*.rb', 'sig/**/*.rbs', 'README.md', 'CHANGELOG.md', 'LICENSE.txt', base: __dir__]
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.4'
  spec.add_development_dependency 'rbs', '~> 4.2'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.91'
  spec.add_development_dependency 'rubocop-performance', '~> 1.27'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.10'
  spec.add_development_dependency 'simplecov', '~> 1.3'
  spec.add_development_dependency 'yard-lint', '~> 1.12'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
