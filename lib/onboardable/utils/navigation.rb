# frozen_string_literal: true

module Onboardable
  module Utils
    module Navigation
      def next_step
        current_index = step_index!(current_step)

        steps[current_index.next]
      end

      def next_step!
        self.current_step = next_step || raise(LastStepError.new(current_step, steps))
      end

      def prev_step
        current_index = step_index!(current_step)

        current_index.positive? ? steps[current_index.pred] : nil
      end

      def prev_step!
        self.current_step = prev_step || raise(FirstStepError.new(current_step, steps))
      end

      def first_step?(step = current_step)
        step == first_step
      end

      def last_step?(step = current_step)
        step == last_step
      end

      def first_step
        steps.fetch(0)
      end

      def last_step
        steps.fetch(-1)
      end
    end
  end
end
