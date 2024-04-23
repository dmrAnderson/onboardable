# frozen_string_literal: true

module Onboardable
  class List
    include Utils::Warnings
    include Navigation

    attr_reader :steps, :current_step

    def initialize(steps, current_step: nil)
      self.steps = steps
      self.current_step = current_step.nil? ? self.steps.fetch(0) : Step.new(current_step)
    end

    private

    def steps=(raw_steps)
      raise InvalidStepsTypeError, raw_steps unless raw_steps.is_a?(Enumerable)

      unique_steps = raw_steps.uniq
      warn_about_duplicates(raw_steps) if unique_steps.size < raw_steps.size
      raise InsufficientUniqueStepsError, unique_steps if unique_steps.size < 2

      @steps = unique_steps.map { |step| Step.new(step) }.freeze
    end

    def current_step=(raw_current_step)
      current_step_index = steps.index { |step| step == raw_current_step }
      raise InvalidStepError.new(raw_current_step, steps.map(&:to_s)) unless current_step_index

      steps.each_with_index { |step, index| step.update_status!(index <=> current_step_index) }
      @current_step = steps.fetch(current_step_index)
    end
  end
end
