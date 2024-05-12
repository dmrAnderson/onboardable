# frozen_string_literal: true

module Onboardable
  # Base error class for Onboardable-related exceptions.
  class Error < StandardError; end

  # Error raised when an operation is attempted on an empty steps collection.
  class EmptyStepsError < Error
    # Initializes a new instance of EmptyStepsError.
    # This error indicates that an operation requiring non-empty steps was attempted on an empty collection.
    def initialize
      super('Cannot be performed because the steps is empty.')
    end
  end

  # Error raised when an invalid step is encountered within the onboarding process.
  class InvalidStepError < Error
    # Initializes a new InvalidStepError with details about the issue.
    #
    # @param step [String] The invalid step that triggered the error.
    # @param expected_steps [Array<String>] The list of valid steps expected at this point.
    def initialize(step, expected_steps)
      super("Invalid step: `#{step}`. Must be one of: `#{expected_steps.join('`, `')}`.")
    end
  end

  # Error raised when an invalid comparison result is encountered in sorting or comparing steps.
  class InvalidComparisonResultError < Error
    # Initializes a new InvalidComparisonResultError with details about the invalid comparison.
    #
    # @param comparison [Integer] The erroneous comparison result.
    # @param expected_comparisons [Array<Integer>] The list of valid comparison results expected.
    def initialize(comparison, expected_comparisons)
      super("Invalid comparison result: `#{comparison}`. Must be one of: #{expected_comparisons.join('`, `')}.")
    end
  end

  # Error raised when attempting to navigate beyond the last step in the onboarding process.
  class LastStepError < Error
    # Initializes a new LastStepError indicating that the end of the step sequence has been reached.
    #
    # @param step [String] The last step that was attempted to be surpassed.
    # @param expected_steps [Array<String>] The complete list of valid steps in the onboarding process.
    def initialize(step, expected_steps)
      super("Currently `#{step}` the last step. Available steps are: `#{expected_steps.join('`, `')}`.")
    end
  end

  # Error raised when attempting to navigate before the first step in the onboarding process.
  class FirstStepError < Error
    # Initializes a new FirstStepError indicating that the beginning of the step sequence has been reached.
    #
    # @param step [String] The first step that was attempted to be preceded.
    # @param expected_steps [Array<String>] The complete list of valid steps in the onboarding process.
    def initialize(step, expected_steps)
      super("Currently `#{step}` the first step. Available steps are: `#{expected_steps.join('`, `')}`.")
    end
  end
end
