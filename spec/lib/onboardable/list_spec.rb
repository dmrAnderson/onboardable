# frozen_string_literal: true

RSpec.describe Onboardable::List do
  let(:raw_steps) { %w[nickname address phone_number] }

  describe '.new' do
    subject(:list_instance) { described_class.new(initial_steps) }

    context 'with duplicate steps' do
      let(:initial_steps) { raw_steps << raw_steps.fetch(0) }

      it 'creates an instance of Onboardable::List' do
        expect(list_instance).to be_an_instance_of(described_class)
      end
    end

    context 'without duplicate steps' do
      let(:initial_steps) { raw_steps }

      it 'creates an instance of Onboardable::List' do
        expect(list_instance).to be_an_instance_of(described_class)
      end
    end

    context 'with an invalid type' do
      let(:initial_steps) { 123 }

      it 'raises an InvalidStepsTypeError' do
        expect { list_instance }.to raise_error(Onboardable::InvalidStepsTypeError)
      end
    end

    context 'with only one unique step' do
      let(:initial_steps) { [raw_steps.fetch(0), raw_steps.fetch(0)] }

      it 'raises an InsufficientUniqueStepsError' do
        expect { list_instance }.to raise_error(Onboardable::InsufficientUniqueStepsError)
      end
    end

    context 'with no steps' do
      let(:initial_steps) { [] }

      it 'raises an InsufficientUniqueStepsError mentioning no steps provided' do
        expect { list_instance }.to raise_error(Onboardable::InsufficientUniqueStepsError)
      end
    end
  end

  describe '#steps' do
    subject(:list_steps) { described_class.new(raw_steps).steps }

    it 'consists of instances of Onboardable::Step' do
      expect(list_steps).to all(be_an_instance_of(Onboardable::Step))
    end

    it 'is frozen to prevent modification' do
      expect(list_steps).to be_frozen
    end

    it 'includes specified steps' do
      expected_step_names = raw_steps.map(&:to_s)
      expect(list_steps.map(&:to_s)).to match_array(expected_step_names)
    end
  end

  describe '#current_step' do
    subject(:current_step) { described_class.new(raw_steps, current_step: raw_current_step).current_step }

    let(:raw_current_step) { raw_steps.sample }

    it 'returns an instance of Onboardable::Step representing the current step' do
      expect(current_step).to be_an_instance_of(Onboardable::Step)
    end

    it 'matches the expected current step' do
      expect(current_step.name).to eq(raw_current_step)
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
    subject(:onboard_list) { described_class.new(raw_steps, current_step: current_step) }

    context 'when not at the last step' do
      let(:current_step) { 'nickname' }

      it 'advances to the next step correctly' do
        expect(onboard_list.next_step!.name).to eq('address')
      end
    end

    context 'when at the last step' do
      let(:current_step) { 'phone_number' }

      it 'raises a LastStepError' do
        expect { onboard_list.next_step! }.to raise_error(Onboardable::LastStepError)
      end
    end
  end

  describe '#prev_step!' do
    subject(:list) { described_class.new(raw_steps, current_step: current_step) }

    context 'when not at the first step' do
      let(:current_step) { 'address' }

      it 'moves to the previous step correctly' do
        expect(list.prev_step!.name).to eq('nickname')
      end
    end

    context 'when at the first step' do
      let(:current_step) { 'nickname' }

      it 'raises a FirstStepError with correct message and step list' do
        expect { list.prev_step! }.to raise_error(Onboardable::FirstStepError)
      end
    end
  end

  describe '#first_step?' do
    subject(:first_step?) { described_class.new(raw_steps, current_step: current_step).first_step? }

    context 'when the current step is the first step' do
      let(:current_step) { 'nickname' }

      it 'returns true' do
        expect(first_step?).to be true
      end
    end

    context 'when the current step is not the first step' do
      let(:current_step) { 'address' }

      it 'returns false' do
        expect(first_step?).to be false
      end
    end
  end

  describe '#last_step?' do
    subject(:last_step?) { described_class.new(raw_steps, current_step: current_step).last_step? }

    context 'when the current step is the last step' do
      let(:current_step) { 'phone_number' }

      it 'returns true' do
        expect(last_step?).to be true
      end
    end

    context 'when the current step is not the last step' do
      let(:current_step) { 'address' }

      it 'returns false' do
        expect(last_step?).to be false
      end
    end
  end
end
