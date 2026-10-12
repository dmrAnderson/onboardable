# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

desc 'Run yard-lint on lib/'
task :yard_lint do
  sh 'bundle exec yard-lint lib/'
end

desc 'Type-check lib/ against RBS signatures in sig/'
task :steep do
  sh 'bundle exec steep check'
end

task default: %i[spec rubocop yard_lint steep]
