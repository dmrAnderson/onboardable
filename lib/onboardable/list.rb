# frozen_string_literal: true

module Onboardable
  class List < Set
    def self.[](*raw_steps)
      new(raw_steps.map { |step| Step.new(step) })
    end
  end
end
