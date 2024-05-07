# frozen_string_literal: true

module Onboardable
  class Step
    PENDING_STATUS = :pending
    CURRENT_STATUS = :current
    COMPLETED_STATUS = :completed
    DEFAULT_STATUS = PENDING_STATUS
    STATUSES = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze

    attr_reader :name, :data, :status

    def initialize(name, data = {})
      self.name = name
      self.data = data

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

    def to_str
      name
    end

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

    def name=(raw_name)
      @name = String.new(String.try_convert(raw_name)).freeze
    end

    def data=(raw_data)
      @data = Hash(Hash.try_convert(raw_data)).freeze
    end

    attr_writer :status
  end
end
