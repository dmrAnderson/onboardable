# frozen_string_literal: true

module Onboardable
  module List
    # The Builder class constructs and manages an onboarding step list, adding steps and building the final list.
    class Builder
      include Utils::Warnings

      STEP_KEY = :steps

      # Stores the steps added to the builder.
      #
      # @return [Hash] A hash of steps added to the builder.
      def steps
        options[STEP_KEY] ||= {}
      end

      # @return [Step] The current step in the building process, defaulting to the first added step.
      attr_accessor :current_step

      # Initializes a new instance of ListBuilder.
      def initialize(options = {})
        self.options = options
      end

      # Creates a new Step object and adds it to the builder.
      #
      # @param name [String] The name of the step.
      # @param data [Hash] The data associated with the step.
      # @return [Step] The created step.
      def create_step(name, data = {})
        Step.new(name, data).tap { |step| add_step(step) }
      end
      alias step create_step

      # Converts a class to a Step object and adds it to the builder.
      #
      # @param klass [Class] The class to be converted to a step.
      # @return [Step] The converted step.
      def create_step_from(klass)
        (Step.try_convert(klass) || undefined_method_error!(klass)).tap { |step| add_step(step) }
      end
      alias step_from create_step_from

      # Constructs a new List object from the steps added to the builder.
      #
      # @param current_step_name [String, nil] The name of the current step.
      # @return [Base] A new List object initialized with the steps and the specified current step.
      def build(current_step_name = nil)
        Base.new(
          convert_to_steps!,
          convert_to_step!(current_step_name || current_step.name),
          options.except(STEP_KEY)
        )
      end

      private

      # @return [Hash] The options hash for the builder.
      attr_reader :options

      # Sets options hash for the builder.
      #
      # @param options [Hash] Options to be set for the builder.
      def options=(options)
        @options = Hash(options).except(STEP_KEY)
      end

      # Adds a step to the builder.
      #
      # @param step [Step] The step to be added.
      # @return [Step] The added step.
      def add_step(step)
        step.name.then do |name|
          warn_about_override(name) if steps.key?(name)
          steps[name] = step
        end

        step.tap { self.current_step ||= step }
      end

      # Converts the internal hash of steps to an array of Step objects.
      #
      # @return [Array<Step>] An array of steps.
      # @raise [EmptyStepsError] Raises if there are no steps to convert.
      def convert_to_steps!
        steps.any? ? steps.values : raise(EmptyStepsError)
      end

      # Retrieves a Step object from the builder's steps based on the step name.
      #
      # @param name [String] The name of the step to be converted to a Step object.
      # @return [Step] The corresponding Step object.
      # @raise [StepError] Raises if the specified step name is not present in steps hash.
      def convert_to_step!(name)
        steps[name] || raise(StepError.new(name, steps.keys))
      end

      # Raises an UndefinedMethodError indicating that the conversion method is not defined for the class.
      #
      # @param klass [Class] The class that does not have the conversion method defined.
      # @raise [UndefinedMethodError] Raises an error indicating the missing conversion method.
      def undefined_method_error!(klass)
        raise UndefinedMethodError.new(klass, Step::CONVERSION_METHOD)
      end
    end
  end
end
