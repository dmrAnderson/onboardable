# frozen_string_literal: true

module Onboardable
  module List
    # The Navigation module provides methods for navigating through the steps of the onboarding process.
    module Navigation
      # Returns the next step in the onboarding process.
      #
      # @return [Step, nil] The next step in the list or nil if the current step is the last one.
      def next_step
        current_index = step_index!(current_step)
        steps[current_index.next]
      end

      # Moves the current step pointer to the next step in the onboarding process.
      #
      # @raise [LastStepError] if the current step is the last step and there is no next step to move to.
      def next_step!
        self.current_step = next_step || raise(LastStepError.new(current_step, steps.map(&:to_str)))
      end

      # Returns the previous step in the onboarding process.
      #
      # @return [Step, nil] The previous step in the list or nil if the current step is the first one.
      def prev_step
        current_index = step_index!(current_step)
        current_index.positive? ? steps[current_index.pred] : nil
      end

      # Moves the current step pointer to the previous step in the onboarding process.
      #
      # @raise [FirstStepError] if the current step is the first step and there is no previous step to move to.
      def prev_step!
        self.current_step = prev_step || raise(FirstStepError.new(current_step, steps.map(&:to_str)))
      end

      # Checks if the specified step is the first step in the onboarding process.
      #
      # @param step [Step] The step to check (defaults to the current step if not specified).
      # @return [Boolean] True if the specified step is the first step, false otherwise.
      def first_step?(step = current_step)
        step == first_step
      end

      # Checks if the specified step is the last step in the onboarding process.
      #
      # @param step [Step] The step to check (defaults to the current step if not specified).
      # @return [Boolean] True if the specified step is the last step, false otherwise.
      def last_step?(step = current_step)
        step == last_step
      end

      # Retrieves the first step in the onboarding process.
      #
      # @return [Step] The first step in the list.
      def first_step
        steps.fetch(0)
      end

      # Retrieves the last step in the onboarding process.
      #
      # @return [Step] The last step in the list.
      def last_step
        steps.fetch(-1)
      end
    end
  end
end
