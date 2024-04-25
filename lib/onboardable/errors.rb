# frozen_string_literal: true

module Onboardable
  class Error < StandardError; end

  class EmptyListError < Error
    def initialize
      super('Cannot be performed because the list is empty.')
    end
  end

  class InvalidStepError < Error
    def initialize(step, expected_steps)
      super("Invalid step: `#{step}`. Must be one of: `#{expected_steps.join('`, `')}`.")
    end
  end

  class InvalidComparisonResultError < Error
    def initialize(comparison, expected_comparisons)
      super("Invalid comparison result: `#{comparison}`. Must be one of: #{expected_comparisons.join('`, `')}.")
    end
  end

  class LastStepError < Error
    def initialize(step, expected_steps)
      super("Currently `#{step}` the last step. Available steps are: `#{expected_steps.join('`, `')}`.")
    end
  end

  class FirstStepError < Error
    def initialize(step, expected_steps)
      super("Currently `#{step}` the first step. Available steps are: `#{expected_steps.join('`, `')}`.")
    end
  end
end
