# frozen_string_literal: true

module Onboardable
  module List
    # The Builder class constructs and manages an onboarding step list, adding steps and building the final list.
    class Builder
      include Utils::Warnings

      # @return [Hash] A hash where keys are step names and values are Step objects.
      attr_reader :steps

      # @return [Step] The current step in the building process, defaulting to the first added step.
      attr_accessor :current_step

      # Initializes a new instance of ListBuilder.
      def initialize
        self.steps = {}
      end

      # Adds a new step to the list with optional custom data.
      #
      # @param name [String] The name of the step.
      # @param data [Hash] A hash of custom data associated with the step (default: empty hash).
      # @return [Step] The newly added step object.
      def add_step(name, data = {})
        Step.new(name, data).tap do |step|
          warn_about_override(name) if steps.key?(name)
          steps[name] = step
          self.current_step ||= step
        end
      end
      alias step add_step

      # Constructs a new List object from the steps added to the builder.
      #
      # @param current_step_name [String] The name of the step to mark as current in the built list.
      # @return [Base] A new List object initialized with the steps and the specified current step.
      # @raise [EmptyStepsError] if no steps have been added to the builder.
      def build!(current_step_name)
        Base.new(convert_to_steps!, convert_to_step!(current_step_name || current_step.name))
      end

      private

      # Assigns a hash of steps to the builder.
      #
      # @param raw_steps [Hash] The hash of steps to be assigned.
      def steps=(raw_steps)
        @steps = Hash(Hash.try_convert(raw_steps))
      end

      # Converts the internal hash of steps to an array of Step objects.
      #
      # @return [Array<Step>] An array of steps.
      # @raise [EmptyStepsError] Raises if there are no steps to convert.
      def convert_to_steps!
        raise EmptyStepsError if steps.empty?

        steps.values
      end

      # Retrieves a Step object from the builder's steps based on the step name.
      #
      # @param name [String] The name of the step to be converted to a Step object.
      # @return [Step] The corresponding Step object.
      # @raise [InvalidStepError] Raises if the specified step name is not present in the steps hash.
      def convert_to_step!(name)
        steps[name] || raise(InvalidStepError.new(name, steps.keys))
      end
    end
  end
end
