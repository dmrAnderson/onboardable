# frozen_string_literal: true

module Onboardable
  class Error < StandardError; end

  class InvalidStatusError < Error
    def initialize(status, *expected_values)
      super("Invalid status: `#{status}`, must be one of: `#{expected_values.join('`, `')}`.")
    end
  end

  class InvalidStepError < Error
    def initialize(step, *expected_values)
      super("Invalid step: `#{step}`, must be one of: `#{expected_values.join('`, `')}`.")
    end
  end

  class InvalidComparisonResultError < Error
    def initialize(comparison_result, *expected_values)
      super("Invalid comparison result: `#{comparison_result}`, must be one of: `#{expected_values.join('`, `')}`.")
    end
  end
end
