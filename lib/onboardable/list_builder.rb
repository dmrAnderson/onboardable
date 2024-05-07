# frozen_string_literal: true

module Onboardable
  class ListBuilder
    attr_reader :steps
    attr_accessor :current_step

    def initialize
      self.steps = {}
    end

    def add_step(name, data = {})
      Step.new(name, data).tap do |step|
        steps[name] = step
        self.current_step ||= step
      end
    end
    alias step add_step

    def build!(current_step_name)
      List.new(steps.values, convert_to_step!(current_step_name))
    end

    private

    def steps=(raw_steps)
      @steps = Hash(Hash.try_convert(raw_steps))
    end

    def convert_to_step!(name)
      return current_step unless name

      steps[name] || raise(InvalidStepError.new(name, steps.keys))
    end
  end
end
