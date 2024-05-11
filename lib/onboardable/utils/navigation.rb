# frozen_string_literal: true

module Onboardable
  module Utils
    # The Navigation module provides methods for navigating through the steps of the onboarding process.
    module Navigation
      # Returns the next step in the onboarding process.
      #
      # @return [Step, nil] the next step, or nil if there is no next step
      def next_step
        current_index = step_index!(current_step)

        steps[current_index.next]
      end

      # Sets the current step to the next step in the onboarding process.
      #
      # @raise [LastStepError] if there is no next step
      def next_step!
        self.current_step = next_step || raise(LastStepError.new(current_step, steps))
      end

      # Returns the previous step in the onboarding process.
      #
      # @return [Step, nil] the previous step, or nil if there is no previous step
      def prev_step
        current_index = step_index!(current_step)

        current_index.positive? ? steps[current_index.pred] : nil
      end

      # Sets the current step to the previous step in the onboarding process.
      #
      # @raise [FirstStepError] if there is no previous step
      def prev_step!
        self.current_step = prev_step || raise(FirstStepError.new(current_step, steps))
      end

      # Checks if the given step is the first step in the onboarding process.
      #
      # @param step [Step] the step to check
      # @return [Boolean] true if the step is the first step, false otherwise
      def first_step?(step = current_step)
        step == first_step
      end

      # Checks if the given step is the last step in the onboarding process.
      #
      # @param step [Step] the step to check
      # @return [Boolean] true if the step is the last step, false otherwise
      def last_step?(step = current_step)
        step == last_step
      end

      # Returns the first step in the onboarding process.
      #
      # @return [Step] the first step
      def first_step
        steps.fetch(0)
      end

      # Returns the last step in the onboarding process.
      #
      # @return [Step] the last step
      def last_step
        steps.fetch(-1)
      end
    end
  end
end
