# frozen_string_literal: true

RSpec.describe Onboardable::List do
  subject(:list) do
    described_class.new(steps, steps.fetch(1)) # starting from 'step2'
  end

  let(:steps) do
    %w[step1 step2 step3].map { |name| Onboardable::Step.new(name, nil) }
  end

  describe '#initialize' do
    it 'assigns given steps to @steps' do
      expect(list.steps).to eq(steps)
    end

    it 'sets the given current step as @current_step' do
      expect(list.current_step).to eq(steps.fetch(1))
    end
  end

  describe '#next_step' do
    context 'when not at the last step' do
      it 'moves to the next step' do
        expect(list.next_step).to eq(steps.fetch(2))
      end
    end

    context 'when at the last step' do
      subject(:last_step_list) { described_class.new(steps, steps.fetch(-1)) }

      it 'raises a LastStepError' do
        expect { last_step_list.next_step }.to raise_error(Onboardable::LastStepError)
      end
    end
  end

  describe '#next_step!' do
    it 'updates the current step to the next step' do
      list.next_step!
      expect(list.current_step).to eq(steps.fetch(2))
    end
  end

  describe '#prev_step' do
    context 'when not at the first step' do
      it 'moves to the previous step' do
        expect(list.prev_step).to eq(steps.fetch(0))
      end
    end

    context 'when at the first step' do
      subject(:first_step_list) { described_class.new(steps, steps.fetch(0)) }

      it 'raises a FirstStepError' do
        expect { first_step_list.prev_step }.to raise_error(Onboardable::FirstStepError)
      end
    end
  end

  describe '#prev_step!' do
    it 'updates the current step to the previous step' do
      list.prev_step!
      expect(list.current_step).to eq(steps.fetch(0))
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
  end
end
