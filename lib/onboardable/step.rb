# frozen_string_literal: true

module Onboardable
  class Step
    PENDING_STATUS   = :pending
    CURRENT_STATUS   = :current
    COMPLETED_STATUS = :completed

    STATUSES       = [PENDING_STATUS, CURRENT_STATUS, COMPLETED_STATUS].freeze
    DEFAULT_STATUS = PENDING_STATUS

    attr_reader :name, :status
    alias to_s name

    def initialize(name, status: DEFAULT_STATUS, allow_logs: false)
      @name = name
      self.status = status
      @allow_logs = allow_logs
    end

    STATUSES.each do |status|
      define_method :"#{status}?" do
        log_status_list_if(self.status, status)

        self.status == status
      end

      define_method :"#{status}!" do
        self.status = status
      end
    end

    def status=(raw_status)
      log_status_list_if(raw_status, status)

      @status = validate_status!(raw_status)
    end

    private

    attr_reader :allow_logs

    def render_status_list(new_status, old_status = nil)
      puts STATUSES.map { |word|
        "\t› #{word}".tap do |status_line|
          status_line << ' ⚑' if word == new_status
          status_line << ' ⚐' if word == old_status
        end
      }.join("\n")
    end

    def log_status_list_if(*args)
      return unless allow_logs

      render_status_list(*args)
    end

    def validate_status!(new_status)
      return new_status if STATUSES.include?(new_status)

      raise InvalidStatusError, "Invalid status: #{new_status}. Must be one of: #{STATUSES.join(', ')}"
    end
  end
end
