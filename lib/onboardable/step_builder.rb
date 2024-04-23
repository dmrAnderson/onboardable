# frozen_string_literal: true

module Onboardable
  class StepsBuilder
    attr_reader :steps

    def initialize
      @steps = []
    end

    def step=(name, _class_representation = nil)
      @steps << name
    end
    alias step step=

    def build!
      List.new(steps)
    end
  end
end
