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
end