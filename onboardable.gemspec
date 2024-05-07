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
  spec.required_ruby_version = '>= 3.0.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = "TODO: Put your gem's public repo URL here."
  spec.metadata['changelog_uri'] = 'https://github.com/dmrAnderson/onboardable/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/dmrAnderson/onboardable/issues'
  spec.metadata['documentation_uri'] = 'https://github.com/dmrAnderson/onboardable/blob/main/README.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency 'rake', '~> 13.2', '>= 13.2.1'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.63', '>= 1.63.4'
  spec.add_development_dependency 'rubocop-performance', '~> 1.21'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.29', '>= 2.29.2'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
