# frozen_string_literal: true

module Onboardable
  module List
    # The List class manages a sequence of steps in an onboarding process, tracking progress and current state.
    class Base
      include Navigation

      # @return [Array<Step>] the steps in the list
      attr_reader :steps

      # @return [Step] the current step in the list
      attr_reader :current_step

      # Initializes a new instance of List with steps and a current step.
      #
      # @param steps [Array<Step>] An array of steps comprising the onboarding process.
      # @param current_step [Step] The step currently active in the process.
      def initialize(steps, current_step)
        self.steps = steps
        self.current_step = current_step
      end

      # Calculates and returns the onboarding progress as a percentage.
      #
      # @return [Float] The completion percentage of the onboarding process.
      def progress
        (step_index!(current_step).to_f / steps.size) * 100
      end

      private

      # Sets and validates the steps array, ensuring it is an Array of Step objects.
      #
      # @param steps [Array<Step>] The steps to be assigned to the list.
      def steps=(steps)
        @steps = Array(Array.try_convert(steps)).freeze
      end

      # Updates the current step and recalibrates the status of all steps in the list.
      #
      # @param raw_current_step [Step] The new current step to set.
      def current_step=(raw_current_step)
        current_step_index = step_index!(raw_current_step)
        steps.each_with_index { |step, index| step.update_status!(index <=> current_step_index) }
        @current_step = steps.fetch(current_step_index)
      end

      # Determines the index of a given step in the list, ensuring the step exists.
      #
      # @param raw_step [Step] The step for which the index is requested.
      # @return [Integer] The index of the step within the list.
      # @raise [InvalidStepError] Raises an error if the step does not exist in the list.
      def step_index!(raw_step)
        steps.index { |step| step == raw_step } || raise(InvalidStepError.new(raw_step.to_str, steps.map(&:to_str)))
      end
    end
  end
end
