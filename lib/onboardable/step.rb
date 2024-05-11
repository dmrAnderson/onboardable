# frozen_string_literal: true

module Onboardable
  # The Step class represents a single step in the onboarding process.
  class Step
    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed
    DEFAULT_STATUS = PENDING_STATUS
    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze

    # @return [String] the name of the step
    attr_reader :name

    # @return [Hash] the custom data associated with the step
    attr_reader :data

    # @return [Symbol] the status of the step
    attr_reader :status

    # Initializes a new Step.
    #
    # @param name [String] the name of the step
    # @param data [Hash] the custom data associated with the step
    def initialize(name, data = {})
      self.name = name
      self.data = data

      self.status = DEFAULT_STATUS
    end

    STATUSES.each do |status_method|
      # Defines a method for each status to check if the step is in that status.
      define_method :"#{status_method}?" do
        status == status_method
      end
    end

    # Checks if the step is equal to another step.
    #
    # @param other [Step] the other step to compare with
    # @return [Boolean] true if the steps are equal, false otherwise
    def ==(other)
      to_str == other.to_str
    end

    # Converts the step to a string.
    #
    # @return [String] the name of the step
    def to_str
      name
    end

    # Updates the status of the step based on a comparison result.
    #
    # @param comparison_result [Integer] the result of the comparison (-1, 0, or 1)
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

    # Sets the name of the step.
    #
    # @param raw_name [String] the raw name of the step
    def name=(raw_name)
      @name = String.new(String.try_convert(raw_name)).freeze
    end

    # Sets the custom data associated with the step.
    #
    # @param raw_data [Hash] the raw custom data
    def data=(raw_data)
      @data = Hash(Hash.try_convert(raw_data)).freeze
    end

    # Sets the status of the step.
    #
    # @param status [Symbol] the status of the step
    attr_writer :status
  end
end
