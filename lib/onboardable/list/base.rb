# frozen_string_literal: true

module Onboardable
  module List
    # The List class manages a sequence of steps in an onboarding process, tracking progress and current state.
    class Base
      include Navigation

      # @return [Array<Step>] The steps in the list.
      attr_reader :steps

      # @return [Step] The current step in the list.
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
        (step_index(current_step).to_f / steps.size) * 100
      end

      private

      # Sets and validates the steps array, ensuring it is an Array of Step objects.
      #
      # @param steps [Array<Step>] The steps to be assigned to the list.
      # @return [Array<Step>] The assigned steps.
      def steps=(steps)
        @steps = Array(Array.try_convert(steps)).freeze
      end

      # Updates the current step and recalibrates the status of all steps in the list.
      #
      # @param raw_current_step [Step] The new current step to set.
      # @return [Step] The updated current step.
      def current_step=(raw_current_step)
        step_index(raw_current_step).then do |index|
          update_each_step_status(index)
          @current_step = steps.fetch(index)
        end
      end

      # Determines the index of a given step in the list, ensuring the step exists.
      #
      # @param raw_step [Step] The step for which the index is requested.
      # @return [Integer] The index of the step within the list.
      def step_index(raw_step)
        steps.index { |step| step == raw_step } || step_error!(raw_step)
      end

      # Updates the status of each step in the list based on the current step index.
      #
      # @param current_step_index [Integer] The index of the current step in the list.
      # @return [Array<Step>] The updated steps array.
      def update_each_step_status(current_step_index)
        steps.each_with_index do |step, index|
          step.update_status!(index <=> current_step_index)
        end
      end

      # Raises a StepError indicating an invalid step was encountered.
      #
      # @param raw_step [Step] The step that triggered the error.
      # @raise [StepError] Raises an error if the step does not exist in the list.
      def step_error!(raw_step)
        raise StepError.new(raw_step.to_str, steps.map(&:to_str))
      end
    end
  end
end
