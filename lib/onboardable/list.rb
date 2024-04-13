# frozen_string_literal: true

module Onboardable
  class List
    attr_reader :steps, :current_step

    def initialize(steps, current_step = nil)
      self.steps = steps
      self.current_step = current_step || steps[0]
    end

    def next; end

    def back; end

    private

    def steps=(new_steps)
      unique_steps = new_steps.uniq
      warn_about_duplicates(new_steps) if unique_steps.size < new_steps.size
      @steps = unique_steps.map { |step| Step.new(step) }.freeze
    end

    def current_step=(new_current_step)
      current_step_index = steps.index { |step| step.public_send(Step::COMPARABLE_KEY) == new_current_step }

      unless current_step_index
        allowed_steps = steps.map { |step| step.public_send(Step::COMPARABLE_KEY) }
        raise InvalidStepError.new(new_current_step, allowed_steps)
      end

      steps.each_with_index { |step, index| step.update_status!(index <=> current_step_index) }
      @current_step = steps.fetch(current_step_index)
    end

    def warn_about_duplicates(new_steps)
      duplicated_steps = new_steps.tally.select { |_, occurrences| occurrences.size > 1 }.keys
      warn("Ignored duplicates: `#{duplicated_steps.join('`, `')}`.", uplevel: 1)
    end
  end
end
