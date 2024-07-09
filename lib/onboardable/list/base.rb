# frozen_string_literal: true

module Onboardable
  module List
    # The List class manages a sequence of steps in an onboarding process, tracking progress and current state.
    class Base
      include Navigation

      PROGRESS_CALCULATION = ->(step_index, steps_size) { (step_index.to_f / steps_size) * 100 }

      # @return [Array<Step>] The steps in the list.
      attr_reader :steps

      # @return [Step] The current step in the list.
      attr_reader :current_step

      # Initializes a new instance of List with steps and a current step.
      #
      # @param steps [Array<Step>] An array of steps comprising the onboarding process.
      # @param current_step [Step] The step currently active in the process.
      # @param options [Hash] An options hash for the list.
      def initialize(steps, current_step, options = {})
        self.steps = steps
        self.current_step = current_step
        self.options = options
      end

      # Calculates and returns the onboarding progress as a percentage.
      #
      # @param progress_calculation [Proc, nil] An optional custom calculation for progress.
      # @return [Float] The percentage of steps completed in the onboarding process.
      def progress(progress_calculation = nil)
        progress_calculation ||= options.fetch(:progress_calculation, PROGRESS_CALCULATION)
        Float(progress_calculation[step_index(current_step), steps.size])
      end

      private

      # @return [Hash] The options hash for the list.
      attr_reader :options

      # Sets and validates the steps array, ensuring it is an Array of Step objects.
      #
      # @param steps [Array<Step>] The steps to be assigned to the list.
      # @return [Array<Step>] The assigned steps.
      def steps=(steps)
        @steps = Array(Array.try_convert(steps)).freeze
      end

      # Updates the current step and recalibrates the status of all steps in the list.
      #
      # @param current_step [Step] The new current step to set.
      # @return [Step] The updated current step.
      def current_step=(current_step)
        step_index(current_step).then do |index|
          update_each_step_status(index)
          @current_step = steps.fetch(index)
        end
      end

      # Sets and validates the options hash, ensuring it is a Hash object.
      #
      # @param options [Hash] The options to be assigned to the list.
      # @return [Hash] The assigned options.
      def options=(options)
        @options = Hash(options).transform_keys(&:to_sym).freeze
      end

      # Determines the index of a given step in the list, ensuring the step exists.
      #
      # @param step [Step] The step for which the index is requested.
      # @return [Integer] The index of the step within the list.
      def step_index(step)
        steps.index { |item| item == step } || step_error!(step)
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
      # @param step [Step] The step that triggered the error.
      # @raise [StepError] Raises an error if the step does not exist in the list.
      def step_error!(step)
        raise StepError.new(step.to_str, steps.map(&:to_str))
      end
    end
  end
end
