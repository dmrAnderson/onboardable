# frozen_string_literal: true

module Onboardable
  class List
    include Utils::Warnings
    include StepSequence

    attr_reader :steps, :current_step

    def initialize(steps, current_step = nil)
      self.steps = steps
      self.current_step = current_step || steps[0]
    end

    private

    def steps=(new_steps)
      unique_steps = new_steps.uniq
      warn_about_duplicates(new_steps) if unique_steps.size < new_steps.size
      @steps = unique_steps.map { |step| Step.new(step) }.freeze
    end

    def current_step=(new_current_step)
      current_step_index = steps.index { |step| step == new_current_step }
      raise InvalidStepError.new(new_current_step, *steps.map(&:to_s)) unless current_step_index

      steps.each_with_index { |step, index| step.update_status!(index <=> current_step_index) }
      @current_step = steps.fetch(current_step_index)
    end
  end
end
