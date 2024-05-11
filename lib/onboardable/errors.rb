# frozen_string_literal: true

module Onboardable
  # Base error class for Onboardable
  class Error < StandardError; end

  # Error raised when an operation is attempted on an empty list
  class EmptyListError < Error
    # Initializes a new EmptyListError
    def initialize
      super('Cannot be performed because the list is empty.')
    end
  end

  # Error raised when an invalid step is encountered
  class InvalidStepError < Error
    # Initializes a new InvalidStepError
    #
    # @param step [String] the invalid step
    # @param expected_steps [Array<String>] the expected steps
    def initialize(step, expected_steps)
      super("Invalid step: `#{step}`. Must be one of: `#{expected_steps.join('`, `')}`.")
    end
  end

  # Error raised when an invalid comparison result is encountered
  class InvalidComparisonResultError < Error
    # Initializes a new InvalidComparisonResultError
    #
    # @param comparison [Integer] the invalid comparison result
    # @param expected_comparisons [Array<Integer>] the expected comparison results
    def initialize(comparison, expected_comparisons)
      super("Invalid comparison result: `#{comparison}`. Must be one of: #{expected_comparisons.join('`, `')}.")
    end
  end

  # Error raised when the last step is encountered
  class LastStepError < Error
    # Initializes a new LastStepError
    #
    # @param step [String] the last step
    # @param expected_steps [Array<String>] the expected steps
    def initialize(step, expected_steps)
      super("Currently `#{step}` the last step. Available steps are: `#{expected_steps.join('`, `')}`.")
    end
  end

  # Error raised when the first step is encountered
  class FirstStepError < Error
    # Initializes a new FirstStepError
    #
    # @param step [String] the first step
    # @param expected_steps [Array<String>] the expected steps
    def initialize(step, expected_steps)
      super("Currently `#{step}` the first step. Available steps are: `#{expected_steps.join('`, `')}`.")
    end
  end
end
