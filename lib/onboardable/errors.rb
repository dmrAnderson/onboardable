# frozen_string_literal: true

module Onboardable
  # Base error class for Onboardable-related exceptions.
  class Error < StandardError; end

  # Error raised when a method is called on an object that does not define it.
  class UndefinedMethodError < Error
    # Initializes a new instance of UndefinedMethodError.
    #
    # @param klass [Class] The class that does not have the method defined.
    # @param method [Symbol, String] The name of the method that is not defined.
    def initialize(klass, method)
      super("Method `#{method}` is not defined for `#{klass}`.")
    end
  end

  # Error raised when an object cannot be converted to a Step.
  class StepConversionError < Error
    # Initializes a new instance of StepConversionError.
    #
    # @param klass [Class] The class that failed to convert.
    # @param step [Object] The object returned by the failed conversion.
    def initialize(klass, step)
      super("can't convert #{klass} to Step (#{klass}#to_onboarding_step gives #{step.class}).")
    end
  end

  # Error raised when an operation is attempted on an empty steps collection.
  class EmptyStepsError < Error
    # Initializes a new instance of EmptyStepsError.
    # This error indicates that an operation requiring non-empty steps was attempted on an empty collection.
    def initialize
      super('Cannot be performed because the steps is empty.')
    end
  end

  # Error raised when an invalid step is encountered within the onboarding process.
  class StepError < Error
    # Initializes a new StepError with details about the issue.
    #
    # @param step [String] The invalid step that triggered the error.
    # @param expected_steps [Array<String>] The list of valid steps expected at this point.
    def initialize(step, expected_steps)
      super("Invalid step: `#{step}`. Must be one of: `#{expected_steps.join('`, `')}`.")
    end
  end

  # Error raised when an invalid comparison result is encountered.
  class ComparisonResultError < Error
    # Initializes a new ComparisonResultError with details about the issue.
    #
    # @param comparison [Integer] The invalid comparison result that triggered the error.
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

  # Error raised when an invalid status is encountered for a step.
  class StepStatusError < Error
    # Initializes a new StepStatusError with details about the issue.
    #
    # @param status [Symbol] The invalid status that triggered the error.
    # @param expected_statuses [Array<Symbol>] The list of valid statuses expected.
    def initialize(status, expected_statuses)
      super("Invalid status: `#{status}`. Must be one of: `#{expected_statuses.join('`, `')}`.")
    end
  end
end
