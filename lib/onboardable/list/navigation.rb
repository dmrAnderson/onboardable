# frozen_string_literal: true

module Onboardable
  module List
    # The Navigation module provides methods for navigating through the steps of the onboarding process.
    module Navigation
      # Returns the next step in the onboarding process.
      #
      # @return [Step, nil] The next step in the list or nil if the current step is the last one.
      def next_step
        current_index = step_index(current_step)
        steps[current_index.next]
      end

      # Checks if the specified step is the next step in the onboarding process.
      #
      # @param step [Step] The step to check.
      # @return [Boolean] True if the specified step is the next step, false otherwise.
      def next_step?(step)
        next_step == step
      end

      # Moves the current step pointer to the next step in the onboarding process.
      #
      # @return [Step] The next step in the list.
      def next_step!
        self.current_step = next_step || last_step_error!
      end

      # Returns the previous step in the onboarding process.
      #
      # @return [Step, nil] The previous step in the list or nil if the current step is the first one.
      def prev_step
        current_index = step_index(current_step)
        current_index.positive? ? steps[current_index.pred] : nil
      end

      # Checks if the specified step is the previous step in the onboarding process.
      #
      # @param step [Step] The step to check.
      # @return [Boolean] True if the specified step is the previous step, false otherwise.
      def prev_step?(step)
        prev_step == step
      end

      # Moves the current step pointer to the previous step in the onboarding process.
      #
      # @return [Step] The previous step in the list.
      def prev_step!
        self.current_step = prev_step || first_step_error!
      end

      # Checks if the specified step is the first step in the onboarding process.
      #
      # @param step [Step] The step to check (defaults to the current step if not specified).
      # @return [Boolean] True if the specified step is the first step, false otherwise.
      def first_step?(step = current_step)
        first_step == step
      end

      # Checks if the specified step is the last step in the onboarding process.
      #
      # @param step [Step] The step to check (defaults to the current step if not specified).
      # @return [Boolean] True if the specified step is the last step, false otherwise.
      def last_step?(step = current_step)
        last_step == step
      end

      # Retrieves the first step in the onboarding process.
      #
      # @return [Step] The first step in the list.
      def first_step
        steps.fetch(0)
      end

      # Checks if the specified step is the current step in the onboarding process.
      #
      # @param step [Step] The step to check.
      # @return [Boolean] True if the specified step is the current step, false otherwise.
      def current_step?(step)
        current_step == step
      end

      # Retrieves the last step in the onboarding process.
      #
      # @return [Step] The last step in the list.
      def last_step
        steps.fetch(-1)
      end

      private

      # Raises a FirstStepError indicating the current step is the first step in the onboarding process.
      #
      # @raise [FirstStepError] The error indicating the current step is the first step.
      def first_step_error!
        raise FirstStepError.new(current_step.name, steps.map(&:to_str))
      end

      # Raises a LastStepError indicating the current step is the last step in the onboarding process.
      #
      # @raise [LastStepError] The error indicating the current step is the last step.
      def last_step_error!
        raise LastStepError.new(current_step.name, steps.map(&:to_str))
      end
    end
  end
end
