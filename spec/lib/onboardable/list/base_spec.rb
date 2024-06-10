# frozen_string_literal: true

RSpec.describe Onboardable::List::Base do
  subject(:list) do
    described_class.new(steps, steps.fetch(1)) # starting from 'step2'
  end

  let(:steps) do
    %w[step1 step2 step3].map { |name| Onboardable::Step.new(name) }
  end

  describe '#initialize' do
    it 'assigns given steps to @steps' do
      expect(list.steps).to eq(steps)
    end

    it 'sets the given current step as @current_step' do
      expect(list.current_step).to eq(steps.fetch(1))
    end

    it 'sets the given options hash as @options' do
      expect(list.instance_variable_get(:@options)).to eq({})
    end
  end

  describe '#progress' do
    context 'when at the first step' do
      subject(:first_step_list) { described_class.new(steps, steps.fetch(0)) }

      it 'returns 0% progress' do
        expect(first_step_list.progress).to eq(0)
      end
    end

    context 'when at the second step of three' do
      it 'returns approximately 33% progress' do
        expect(list.progress.to_i).to eq(33)
      end
    end

    context 'when at the last step' do
      subject(:last_step_list) { described_class.new(steps, steps.fetch(-1)) }

      it 'returns 66% progress' do
        expect(last_step_list.progress.to_i).to eq(66)
      end
    end

    context 'when using a custom progress calculation' do
      subject(:custom_progress_list) do
        described_class.new(steps, steps.fetch(1), progress_calculation: custom_progress_calculation)
      end

      let(:custom_progress_calculation) { ->(step_index, steps_size) { step_index + steps_size } }

      it 'returns a Float' do
        expect(custom_progress_list.progress).to be_an_instance_of(Float)
      end

      it 'returns the result of the custom calculation' do
        expect(custom_progress_list.progress).to eq(4)
      end

      it 'accepts a custom calculation as an argument' do
        dynamic_progress_calculation = ->(step_index, steps_size) { step_index + steps_size + 1 }
        expect(custom_progress_list.progress(dynamic_progress_calculation)).to eq(5)
      end
    end
  end

  describe '#next_step' do
    context 'when not at the last step' do
      it 'returns the next step without changing the current step' do
        expect(list.next_step).to eq(steps.fetch(2))
      end
    end

    context 'when at the last step' do
      subject(:last_step_list) { described_class.new(steps, steps.fetch(-1)) }

      it 'returns nil for the next step' do
        expect(last_step_list.next_step).to be_nil
      end
    end
  end

  describe '#next_step?' do
    it 'returns true for the next step' do
      expect(list.next_step?(steps.fetch(2))).to be(true)
    end

    it 'returns false for any other step' do
      expect(list.next_step?(steps.fetch(0))).to be(false)
    end
  end

  describe '#next_step!' do
    context 'when not at the last step' do
      it 'advances the current step to the next step' do
        expect { list.next_step! }.to change(list, :current_step).from(steps.fetch(1)).to(steps.fetch(2))
      end
    end

    context 'when at the last step' do
      subject(:last_step_list) { described_class.new(steps, steps.fetch(-1)) }

      it 'raises a LastStepError' do
        expect { last_step_list.next_step! }.to raise_error(Onboardable::LastStepError)
      end
    end
  end

  describe '#prev_step' do
    context 'when not at the first step' do
      it 'returns the previous step without changing the current step' do
        expect(list.prev_step).to eq(steps.fetch(0))
      end
    end

    context 'when at the first step' do
      subject(:first_step_list) { described_class.new(steps, steps.fetch(0)) }

      it 'returns nil for the previous step' do
        expect(first_step_list.prev_step).to be_nil
      end
    end
  end

  describe '#prev_step?' do
    it 'returns true for the previous step' do
      expect(list.prev_step?(steps.fetch(0))).to be(true)
    end

    it 'returns false for any other step' do
      expect(list.prev_step?(steps.fetch(2))).to be(false)
    end
  end

  describe '#prev_step!' do
    context 'when not at the first step' do
      it 'reverts the current step to the previous step' do
        expect { list.prev_step! }.to change(list, :current_step).from(steps.fetch(1)).to(steps.fetch(0))
      end
    end

    context 'when at the first step' do
      subject(:first_step_list) { described_class.new(steps, steps.fetch(0)) }

      it 'raises a FirstStepError' do
        expect { first_step_list.prev_step! }.to raise_error(Onboardable::FirstStepError)
      end
    end
  end

  describe '#first_step?' do
    context 'when at the first step' do
      subject(:first_step_list) { described_class.new(steps, steps.fetch(0)) }

      it 'returns true' do
        expect(first_step_list.first_step?).to be true
      end
    end

    context 'when not at the first step' do
      it 'returns false' do
        expect(list.first_step?).to be false
      end
    end

    context 'when checking a specific step explicitly' do
      it 'returns true if the specified step is the first' do
        expect(list.first_step?(steps.fetch(0))).to be true
      end

      it 'returns false if the specified step is not the first' do
        expect(list.first_step?(steps.fetch(-1))).to be false
      end
    end
  end

  describe '#last_step?' do
    context 'when at the last step' do
      subject(:last_step_list) { described_class.new(steps, steps.fetch(-1)) }

      it 'returns true' do
        expect(last_step_list.last_step?).to be true
      end
    end

    context 'when not at the last step' do
      it 'returns false' do
        expect(list.last_step?).to be false
      end
    end

    context 'when checking a specific step explicitly' do
      it 'returns true if the specified step is the last' do
        expect(list.last_step?(steps.fetch(-1))).to be true
      end

      it 'returns false if the specified step is not the last' do
        expect(list.last_step?(steps.fetch(0))).to be false
      end
    end
  end

  describe '#current_step?' do
    it 'returns true for the current step' do
      expect(list.current_step?(steps.fetch(1))).to be true
    end

    it 'returns false for any other step' do
      expect(list.current_step?(steps.fetch(0))).to be false
    end
  end

  describe '#step_index' do
    it 'returns the index of the specified step' do
      expect(list.send(:step_index, steps.fetch(1))).to eq(1)
    end

    it 'raises a StepError if the step is not in the list' do
      expect { list.send(:step_index, Onboardable::Step.new('step4')) }.to raise_error(Onboardable::StepError)
    end
  end
end
