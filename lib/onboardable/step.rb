# frozen_string_literal: true

module Onboardable
  class Step
    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed
    DEFAULT_STATUS = PENDING_STATUS
    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze

    attr_reader :name, :representation, :status

    def initialize(name, representation)
      self.name = name
      self.representation = representation
      self.status = DEFAULT_STATUS
    end

    STATUSES.each do |status_method|
      define_method :"#{status_method}?" do
        status == status_method
      end
    end

    def ==(other)
      to_str == other.to_str
    end

    def to_s
      name
    end
    alias to_str to_s

    def update_status!(comparison_result)
      case comparison_result
      when -1
        self.status = COMPLETED_STATUS
      when 0
        self.status = CURRENT_STATUS
      when 1
        self.status = PENDING_STATUS
      else
        raise InvalidComparisonResultError.new(comparison_result, [-1, 0, 1])
      end
    end

    private

    def name=(raw_name)
      @name = String.new(String.try_convert(raw_name))
    end

    attr_writer :representation, :status
  end
end
