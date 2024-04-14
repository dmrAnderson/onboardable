# frozen_string_literal: true

module Onboardable
  class Step
    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed
    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze
    DEFAULT_STATUS = PENDING_STATUS

    include Comparable

    attr_reader :name, :status

    def initialize(name, status: DEFAULT_STATUS)
      @name = name
      self.status = status
    end

    STATUSES.each do |status_method|
      define_method :"#{status_method}?" do
        status == status_method
      end
    end

    def status=(new_status)
      raise InvalidStatusError.new(new_status, STATUSES) unless STATUSES.include?(new_status)

      @status = new_status
    end

    def <=>(other)
      to_s <=> other.to_s
    end

    def to_s
      name.to_s
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
        raise InvalidComparisonResultError.new(comparison_result, -1, 0, 1)
      end
    end
  end
end
