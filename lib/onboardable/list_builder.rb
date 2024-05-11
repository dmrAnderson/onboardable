# frozen_string_literal: true

module Onboardable
  # The ListBuilder class is responsible for building a list of steps for the onboarding process.
  class ListBuilder
    # @return [Hash] the steps in the list
    attr_reader :steps

    # @return [Step] the current step in the list
    attr_accessor :current_step

    # Initializes a new ListBuilder.
    def initialize
      self.steps = {}
    end

    # Adds a new step to the list.
    #
    # @param name [String] the name of the step
    # @param data [Hash] the custom data associated with the step
    # @return [Step] the newly added step
    def add_step(name, data = {})
      Step.new(name, data).tap do |step|
        steps[name] = step
        self.current_step ||= step
      end
    end
    alias step add_step

    # Builds a new List from the steps in the ListBuilder.
    #
    # @param current_step_name [String] the name of the current step
    # @return [List] the newly built list
    def build!(current_step_name)
      List.new(steps.values, convert_to_step!(current_step_name))
    end

    private

    # Sets the steps in the list.
    #
    # @param raw_steps [Hash] the raw steps
    def steps=(raw_steps)
      @steps = Hash(Hash.try_convert(raw_steps))
    end

    # Converts a step name to a Step object.
    #
    # @param name [String] the name of the step
    # @return [Step] the corresponding Step object
    # @raise [InvalidStepError] if the step name is not in the list
    def convert_to_step!(name)
      return current_step unless name

      steps[name] || raise(InvalidStepError.new(name, steps.keys))
    end
  end
end
