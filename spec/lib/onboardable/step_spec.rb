# frozen_string_literal: true

RSpec.describe Onboardable::Step do
  describe '#initialize' do
    subject(:step) { described_class.new('Register', data) }

    let(:data) { { detail: 'Details about the step' } }

    it 'assigns a name' do
      expect(step.name).to eq('Register')
    end

    it 'freezes the name to prevent modification' do
      expect(step.name).to be_frozen
    end

    it 'assigns data' do
      expect(step.data).to eq(data)
    end

    it 'freezes the data to prevent modification' do
      expect(step.data).to be_frozen
    end

    it 'sets the default status to pending' do
      expect(step.status).to eq(Onboardable::Step::PENDING_STATUS)
    end
  end

  describe 'status predicates' do
    let(:step) { described_class.new('Register') }

    context 'when the status is pending' do
      it 'returns true for pending?' do
        expect(step.pending?).to be true
      end

      it 'returns false for current?' do
        expect(step.current?).to be false
      end

      it 'returns false for completed?' do
        expect(step.completed?).to be false
      end
    end
  end

  describe '#==' do
    let(:step) { described_class.new('Register') }
    let(:another_step) { described_class.new('Register') }
    let(:different_step) { described_class.new('Confirm') }

    it 'is equal to another step with the same name' do
      expect(step).to eq(another_step)
    end

    it 'is not equal to another step with a different name' do
      expect(step).not_to eq(different_step)
    end
  end

  describe '#to_str' do
    let(:step) { described_class.new('Register') }

    it 'returns the name of the step' do
      expect(step.to_str).to eq('Register')
    end
  end

  describe '#update_status!' do
    let(:step) { described_class.new('Register') }

    context 'when comparison result is -1' do
      it 'sets the status to completed' do
        step.update_status!(-1)
        expect(step.status).to eq(Onboardable::Step::COMPLETED_STATUS)
      end
    end

    context 'when comparison result is 0' do
      it 'sets the status to current' do
        step.update_status!(0)
        expect(step.status).to eq(Onboardable::Step::CURRENT_STATUS)
      end
    end

    context 'when comparison result is 1' do
      it 'sets the status to pending' do
        step.update_status!(1)
        expect(step.status).to eq(Onboardable::Step::PENDING_STATUS)
      end
    end

    it 'raises an error for an invalid comparison result' do
      expect do
        step.update_status!(2)
      end.to raise_error(Onboardable::ComparisonResultError)
    end
  end

  describe '.try_convert' do
    let(:valid_object) do
      Class.new { def self.to_onboarding_step = Onboardable::Step.new('Test Step') }
    end

    let(:invalid_object) do
      Class.new { def self.to_onboarding_step = 'Invalid Step' }
    end

    let(:no_conversion_method_object) { Object.new }

    context 'when the object can be converted to a Step' do
      let(:step) { described_class.try_convert(valid_object) }

      it 'returns a step' do
        expect(step).to be_a(described_class)
      end

      it 'assigns the correct name' do
        expect(step.name).to eq('Test Step')
      end
    end

    it 'raises a StepConversionError if the conversion does not return a Step' do
      expect { described_class.try_convert(invalid_object) }.to raise_error(Onboardable::StepConversionError)
    end

    it 'returns nil if the object does not respond to the conversion method' do
      expect(described_class.try_convert(no_conversion_method_object)).to be_nil
    end
  end
end
