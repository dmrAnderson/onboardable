# frozen_string_literal: true

module Onboardable
  class Step
    PENDING_STATUS   = :pending
    CURRENT_STATUS   = :current
    COMPLETED_STATUS = :completed

    STATUSES       = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze
    DEFAULT_STATUS = PENDING_STATUS

    attr_reader :name, :status

    def initialize(name, status: DEFAULT_STATUS)
      @name = name
      self.status = status
    end

    STATUSES.each do |status|
      define_method :"#{status}?" do
        self.status == status
      end

      define_method :"#{status}!" do
        self.status = validate_status!(status)
      end
    end

    def to_s
      "#{name} (#{status})"
    end
    alias inspect to_s

    def status=(raw_status)
      @status = validate_status!(raw_status)
    end

    private

    def validate_status!(new_status)
      return new_status if STATUSES.include?(new_status)

      raise InvalidStatusError, "Invalid status: #{new_status}. Must be one of: #{STATUSES.join(', ')}"
    end
  end
end
