# frozen_string_literal: true

module Onboardable
  class Step
    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed
    DEFAULT_STATUS = PENDING_STATUS
    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze

    attr_reader :name
    attr_accessor :status, :representation

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
      to_s == other.to_s
    end

    def to_s
      name
    end

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
      @name = raw_name.to_s
    end
  end
end
