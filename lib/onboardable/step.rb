# frozen_string_literal: true

module Onboardable
  # Represents a single step within an onboarding process, including its status and associated data.
  class Step
    CONVERSION_METHOD = :to_onboarding_step

    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed

    DEFAULT_STATUS = PENDING_STATUS

    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze

    class << self
      # Attempts to convert a class to a Step object using a specified conversion method.
      #
      # @param klass [Class] The class to convert to a Step
      # @return [Step, nil] The converted Step object, or nil if the class does not respond to the conversion method
      def try_convert(klass)
        return unless klass.respond_to?(CONVERSION_METHOD)

        klass.public_send(CONVERSION_METHOD).then do |step|
          step.is_a?(Step) ? step : conversion_error!(klass, step)
        end
      end

      private

      # Raises an error for a failed conversion attempt.
      #
      # @param klass [Class] The class that failed to convert
      # @raise [StepConversionError] Raises an error for a failed conversion attempt
      def conversion_error!(klass, step)
        raise StepConversionError.new(klass, step)
      end
    end

    # @return [String] The name of the step
    attr_reader :name

    # @return [Hash] Custom data associated with the step
    attr_reader :data

    # @return [Symbol] The current status of the step
    attr_reader :status

    # Initializes a new Step with a name, optional custom data, and a default status.
    #
    # @param name [String] The name of the step
    # @param data [Hash] The custom data associated with the step, defaults to an empty hash
    def initialize(name, data = {})
      self.name = name
      self.data = data
      self.status = DEFAULT_STATUS
    end

    # Checks if the step is in the pending status.
    #
    # @return [Boolean] True if the step is currently in the pending status, false otherwise.
    def pending?
      status == PENDING_STATUS
    end

    # Checks if the step is in the current status.
    #
    # @return [Boolean] True if the step is currently in the current status, false otherwise.
    def current?
      status == CURRENT_STATUS
    end

    # Checks if the step is in the completed status.
    #
    # @return [Boolean] True if the step is currently in the completed status, false otherwise.
    def completed?
      status == COMPLETED_STATUS
    end

    # Compares this step to another to determine if they are equivalent, based on the step name.
    #
    # @param other [Step] The step to compare with
    # @return [Boolean] True if both steps have the same name, false otherwise
    def ==(other)
      to_str == other.to_str
    end

    # Provides a string representation of the step, using its name.
    #
    # @return [String] The name of the step
    def to_str
      name
    end

    # Updates the status of the step based on a specified comparison result.
    #
    # @param comparison_result [Integer] The result of a comparison with the current step (-1, 0, or 1)
    # @return [Symbol] The new status of the step
    def update_status!(comparison_result)
      self.status = case comparison_result
                    when -1 then COMPLETED_STATUS
                    when 0 then CURRENT_STATUS
                    when 1 then PENDING_STATUS
                    else comparison_result_error!(comparison_result); end
    end

    private

    # Sets the name of the step, ensuring it is a valid String.
    #
    # @param name [String] The raw name of the step
    def name=(name)
      @name = String.new(name).freeze
    end

    # Sets the status of the step.
    #
    # @param status [Symbol] The new status of the step
    def status=(status)
      STATUSES.include?(status) || raise(StepStatusError.new(status, STATUSES))

      @status = status
    end

    # Sets the custom data for the step, ensuring it is a valid Hash.
    #
    # @param data [Hash] The raw custom data
    def data=(data)
      @data = Hash(data).freeze
    end

    # Raises an error for an invalid comparison result.
    #
    # @param comparison_result [Integer] The invalid comparison result
    # @raise [ComparisonResultError] Raises an error for an invalid comparison result
    def comparison_result_error!(comparison_result)
      raise ComparisonResultError.new(comparison_result, (-1..1).to_a)
    end
  end
end
