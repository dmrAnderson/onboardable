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
        self.status = status
      end
    end

    def status=(raw_status)
      @status = validate_status!(raw_status)
    end

    def previous!
      self.status = find_status!(status, &:pred)
    end
    alias up! previous!

    def next!
      self.status = find_status!(status, &:next)
    end
    alias down! next!

    def to_s
      "#{name} (#{status})"
    end

    private

    def find_status!(raw_status)
      STATUSES.index(raw_status).then do |old_index|
        invalid_status!(raw_status) unless old_index

        yield(old_index).then do |index|
          invalid_transition!(raw_status) if index.negative?
          STATUSES[index] || invalid_transition!(raw_status)
        end
      end
    end

    def validate_status!(raw_status)
      return raw_status if STATUSES.include?(raw_status)

      invalid_status!(raw_status)
    end

    def invalid_status!(raw_status)
      raise InvalidStatusError, "Invalid status: #{raw_status}, must be one of: #{STATUSES.join(', ')}."
    end

    def invalid_transition!(raw_status)
      raise InvalidTransitionError, "Cannot transition from #{raw_status}."
    end
  end
end
