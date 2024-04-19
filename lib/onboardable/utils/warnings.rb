# frozen_string_literal: true

module Onboardable
  module Utils
    module Warnings
      private

      def warn_about_duplicates(new_steps)
        duplicated_steps = new_steps.tally.select { |_, occurrences| occurrences.size > 1 }.keys
        warn("Ignored duplicates: `#{duplicated_steps.join('`, `')}`.", uplevel: 1)
      end
    end
  end
end
