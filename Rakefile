# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

namespace :onboardable do
  desc 'Updates RubyGems, installs dependencies'
  task :install do
    puts 'Running bundle install'
    sh 'gem update --system'
    sh 'bundle'
  end

  desc 'Builds the gem'
  task :build do
    puts 'Building'
    sh 'gem build onboardable.gemspec'
  end
end

task ci: %i[spec rubocop]

task full_build: %w[onboardable:install onboardable:build]

task default: :full_build
