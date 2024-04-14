# frozen_string_literal: true

module Onboardable
  module Utils
    module Warnings
      def warn_about_duplicates(steps)
        duplicated_steps = steps.tally.select { |_, occurrences| occurrences.size > 1 }.keys
        warn("Ignored duplicates: `#{duplicated_steps.join('`, `')}`.", uplevel: 1)
      end
    end
  end
end
