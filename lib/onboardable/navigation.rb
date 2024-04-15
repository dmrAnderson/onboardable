# frozen_string_literal: true

module Onboardable
  module Navigation
    def next_step!
      current_index = steps.index(current_step)
      raise LastStepError.new(current_step.name, *steps.map(&:name)) if current_index >= steps.size.pred

      self.current_step = steps.fetch(current_index.next)
    end

    def prev_step!
      current_index = steps.index(current_step)
      raise FirstStepError.new(current_step.name, *steps.map(&:name)) unless current_index.positive?

      self.current_step = steps.fetch(current_index.pred)
    end
  end
end
