# frozen_string_literal: true

module Onboardable
  module Utils
    # The Warnings module provides utility methods for issuing warnings.
    module Warnings
      private

      # Issues a warning when a step with the same name already exists and will be overridden.
      #
      # @param name [String] The name of the step that will be overridden.
      # @return [void] Returns nothing.
      def warn_about_override(name)
        warn "Step `#{name}` already exists and will be overridden.", uplevel: 1
      end
    end
  end
end
