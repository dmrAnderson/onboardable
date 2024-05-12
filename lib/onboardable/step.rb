# frozen_string_literal: true

module Onboardable
  # Represents a single step within an onboarding process, including its status and associated data.
  class Step
    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed
    DEFAULT_STATUS = PENDING_STATUS
    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze

    # @return [String] the name of the step
    attr_reader :name

    # @return [Hash] custom data associated with the step
    attr_reader :data

    # @return [Symbol] the current status of the step
    attr_reader :status

    # Initializes a new Step with a name, optional custom data, and a default status.
    #
    # @param name [String] the name of the step
    # @param data [Hash] the custom data associated with the step, defaults to an empty hash
    def initialize(name, data = {})
      self.name = name
      self.data = data
      self.status = DEFAULT_STATUS
    end

    STATUSES.each do |status_method|
      # @!method {status_method}?
      # Checks if the step is in a specific status.
      #
      # @return [Boolean] true if the step is currently in the {status_method} status, false otherwise.
      define_method :"#{status_method}?" do
        status == status_method
      end
    end

    # Compares this step to another to determine if they are equivalent, based on the step name.
    #
    # @param other [Step] the step to compare with
    # @return [Boolean] true if both steps have the same name, false otherwise
    def ==(other)
      to_str == other.to_str
    end

    # Provides a string representation of the step, using its name.
    #
    # @return [String] the name of the step
    def to_str
      name
    end

    # Updates the status of the step based on a specified comparison result.
    #
    # @param comparison_result [Integer] the result of a comparison with the current step (-1, 0, or 1)
    # @raise [InvalidComparisonResultError] if the comparison result is not -1, 0, or 1
    def update_status!(comparison_result)
      self.status = case comparison_result
                    when -1 then COMPLETED_STATUS
                    when 0 then CURRENT_STATUS
                    when 1 then PENDING_STATUS
                    else
                      raise InvalidComparisonResultError.new(comparison_result, [-1, 0, 1])
                    end
    end

    private

    # Sets the name of the step, ensuring it is a valid String.
    #
    # @param raw_name [String] the raw name of the step
    def name=(raw_name)
      @name = String.new(String.try_convert(raw_name)).freeze
    end

    # Sets the custom data for the step, ensuring it is a valid Hash.
    #
    # @param raw_data [Hash] the raw custom data
    def data=(raw_data)
      @data = Hash(Hash.try_convert(raw_data)).freeze
    end

    # Sets the status of the step.
    #
    # @param status [Symbol] the new status of the step
    attr_writer :status
  end
end
