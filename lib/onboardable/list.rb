# frozen_string_literal: true

module Onboardable
  class List
    attr_reader :steps, :current_step

    def initialize(steps, current_step)
      self.steps = steps
      self.current_step = current_step
    end

    def next_step
      current_index = step_index!(current_step)

      steps[current_index.next]
    end

    def next_step!
      self.current_step = next_step || raise(LastStepError.new(current_step, steps))
    end

    def prev_step
      current_index = step_index!(current_step)

      current_index.positive? ? steps[current_index.pred] : nil
    end

    def prev_step!
      self.current_step = prev_step || raise(FirstStepError.new(current_step, steps))
    end

    def first_step?
      current_step == steps.fetch(0)
    end

    def last_step?
      current_step == steps.fetch(-1)
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
      steps.index { |step| step == raw_step } || raise(InvalidStepError.new(raw_step, steps.map(&:name)))
    end
  end
end
