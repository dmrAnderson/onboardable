# frozen_string_literal: true

require_relative 'onboardable/version'
require_relative 'onboardable/errors'
require_relative 'onboardable/list'
require_relative 'onboardable/step'

module Onboardable
  class Base
    class << self
      def call(raw_steps)
        new(raw_steps).list
      end
    end

    attr_reader :list

    def initialize(raw_steps)
      self.steps = raw_steps
      self.list = steps
    end

    private

    attr_reader :steps

    def steps=(raw_steps)
      @steps = Set.new(raw_steps).clear.tap do |unique_steps|
        raw_steps.find_all { |raw_step| !unique_steps.add?(raw_step) }.then do |duplicated_steps|
          next if duplicated_steps.none?

          warn(
            "Ignored duplicates: #{duplicated_steps.join(', ')}",
            "Original steps: #{raw_steps.join(', ')}",
            uplevel: 1
          )
        end
      end
    end

    def list=(steps)
      @list = List[*steps]
    end
  end
end
