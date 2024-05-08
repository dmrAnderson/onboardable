# frozen_string_literal: true

module Onboardable
  class List
    include Utils::Navigation

    attr_reader :steps, :current_step

    def initialize(steps, current_step)
      self.steps = steps
      self.current_step = current_step
    end

    def progress
      (step_index!(current_step).to_f / steps.size) * 100
    end

    private

    def steps=(raw_steps)
      Array(Array.try_convert(raw_steps)).then do |converted_steps|
        raise EmptyListError if converted_steps.empty?

        @steps = converted_steps.freeze
      end
    end

    def current_step=(raw_current_step)
      current_step_index = step_index!(raw_current_step)
      steps.each_with_index { |step, index| step.update_status!(index <=> current_step_index) }
      @current_step = steps.fetch(current_step_index)
    end

    def step_index!(raw_step)
      steps.index { |step| step == raw_step } || raise(InvalidStepError.new(raw_step, steps.map(&:to_str)))
    end
  end
end
