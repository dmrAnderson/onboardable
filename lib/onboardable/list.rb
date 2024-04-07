# frozen_string_literal: true

module Onboardable
  class List
    attr_reader :steps, :current_step

    def initialize(raw_steps, raw_current_step = nil)
      self.steps = raw_steps
      self.current_step = (raw_current_step || raw_steps[0])
    end

    private

    def steps=(raw_steps)
      unique_steps = raw_steps.uniq
      warn_about_duplicates(raw_steps) if unique_steps.size < raw_steps.size
      @steps = unique_steps.map { |step| Step.new(step) }.freeze
    end

    def current_step=(raw_current_step)
      current_step_index = steps.index { |step| step.name == raw_current_step }
      raise ArgumentError, "Unknown step `#{raw_current_step}`" unless current_step_index

      steps.each_with_index do |step, index|
        step.update_status(index <=> current_step_index)
      end

      @current_step = steps[current_step_index]
    end

    def warn_about_duplicates(raw_steps)
      duplicated_steps = raw_steps.group_by { |step| step }.select { |_, occurrences| occurrences.size > 1 }.keys
      warn("Ignored duplicates: `#{duplicated_steps.join('`, `')}`.", uplevel: 1)
    end
  end
end
