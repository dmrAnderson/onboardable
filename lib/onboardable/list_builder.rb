# frozen_string_literal: true

module Onboardable
  class ListBuilder
    attr_reader :steps

    def initialize(steps: {})
      @steps = steps
    end

    def step=(name, _class_representation = nil)
      steps[name] = Step.new(name)
    end
    alias step step=

    def build!(current_step = nil)
      List.new(steps, current_step)
    end
  end
end
