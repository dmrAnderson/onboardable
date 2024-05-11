# frozen_string_literal: true

module Onboardable
  # The List class represents a list of steps in the onboarding process.
  class List
    include Utils::Navigation

    # @return [Array<Step>] the steps in the list
    attr_reader :steps

    # @return [Step] the current step in the list
    attr_reader :current_step

    # Initializes a new List.
    #
    # @param steps [Array<Step>] the steps in the list
    # @param current_step [Step] the current step in the list
    def initialize(steps, current_step)
      self.steps = steps
      self.current_step = current_step
    end

    # Returns the progress of the onboarding process as a percentage.
    #
    # @return [Float] the progress of the onboarding process
    def progress
      (step_index!(current_step).to_f / steps.size) * 100
    end

    private

    # Sets the steps in the list.
    #
    # @param raw_steps [Array<Step>] the raw steps
    # @raise [EmptyListError] if the list of steps is empty
    def steps=(raw_steps)
      Array(Array.try_convert(raw_steps)).then do |converted_steps|
        raise EmptyListError if converted_steps.empty?

        @steps = converted_steps.freeze
      end
    end

    # Sets the current step in the list.
    #
    # @param raw_current_step [Step] the raw current step
    def current_step=(raw_current_step)
      current_step_index = step_index!(raw_current_step)
      steps.each_with_index { |step, index| step.update_status!(index <=> current_step_index) }
      @current_step = steps.fetch(current_step_index)
    end

    # Returns the index of the given step in the list.
    #
    # @param raw_step [Step] the raw step
    # @return [Integer] the index of the step
    # @raise [InvalidStepError] if the step is not in the list
    def step_index!(raw_step)
      steps.index { |step| step == raw_step } || raise(InvalidStepError.new(raw_step.to_str, steps.map(&:to_str)))
    end
  end
end
