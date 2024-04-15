# frozen_string_literal: true

RSpec.describe Onboardable::List do
  let(:raw_steps) { %w[nickname address phone_number] }

  describe '.new' do
    subject(:list_instance) { described_class.new(steps) }

    context 'when initialized with duplicate steps' do
      let(:steps) { raw_steps + raw_steps } # Demonstrates duplication more clearly

      it 'creates an instance of Onboardable::List' do
        expect(list_instance).to be_an_instance_of(described_class)
      end
    end

    context 'when initialized without duplicate steps' do
      let(:steps) { raw_steps }

      it 'creates an instance of Onboardable::List' do
        expect(list_instance).to be_an_instance_of(described_class)
      end
    end
  end

  describe '#steps' do
    subject(:steps) { described_class.new(raw_steps).steps }

    it 'contains elements that are all instances of Onboardable::Step' do
      expect(steps).to all(be_an_instance_of(Onboardable::Step))
    end

    it 'is frozen to prevent modification' do
      expect(steps).to be_frozen
    end
  end

  describe '#current_step' do
    subject(:current_step) { described_class.new(raw_steps, raw_current_step).current_step }

    let(:raw_current_step) { raw_steps.sample }

    it 'returns an instance of Onboardable::Step representing the current step' do
      expect(current_step).to be_an_instance_of(Onboardable::Step)
    end

    it 'matches the expected current step' do
      expect(current_step).to eq(Onboardable::Step.new(raw_current_step))
    end

    it 'is marked as the current step' do
      expect(current_step).to be_current
    end

    context 'when step is invalid' do
      let(:raw_current_step) { 'Invalid Step' }

      it 'raises an InvalidStepError' do
        expect { current_step }.to raise_error(Onboardable::InvalidStepError)
      end
    end
  end

  describe '#next_step!' do
    subject(:list) { described_class.new(raw_steps, current_step) }

    context 'when not at the last step' do
      let(:current_step) { 'nickname' }

      before { list.next_step! }

      it 'advances to the next step' do
        expect(list.current_step.name).to eq('address')
      end
    end

    context 'when at the last step' do
      let(:current_step) { 'phone_number' }

      it 'raises a LastStepError' do
        expect { list.next_step! }.to raise_error(Onboardable::LastStepError)
      end
    end
  end

  describe '#prev_step!' do
    subject(:list) { described_class.new(raw_steps, current_step) }

    context 'when not at the first step' do
      let(:current_step) { 'address' }

      before { list.prev_step! }

      it 'moves to the previous step' do
        expect(list.current_step.name).to eq('nickname')
      end
    end

    context 'when at the first step' do
      let(:current_step) { 'nickname' }

      it 'raises a FirstStepError' do
        expect { list.prev_step! }.to raise_error(Onboardable::FirstStepError)
      end
    end
  end
end
