# frozen_string_literal: true

RSpec.describe Onboardable::Step do
  describe '#initialize' do
    subject(:step) { described_class.new('Register', representation) }

    let(:representation) { Class.new }

    it 'assigns a name' do
      expect(step.name).to eq('Register')
    end

    it 'assigns a representation' do
      expect(step.representation).to eq(representation)
    end

    it 'sets the default status to pending' do
      expect(step.status).to eq(Onboardable::Step::PENDING_STATUS)
    end
  end

  describe 'status predicates' do
    let(:step) { described_class.new('Register', nil) }

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
    let(:step) { described_class.new('Register', nil) }
    let(:another_step) { described_class.new('Register', nil) }
    let(:different_step) { described_class.new('Confirm', nil) }

    it 'is equal to another step with the same name' do
      expect(step).to eq(another_step)
    end

    it 'is not equal to another step with a different name' do
      expect(step).not_to eq(different_step)
    end
  end

  describe '#to_s' do
    let(:step) { described_class.new('Register', nil) }

    it 'returns the name of the step' do
      expect(step.to_s).to eq('Register')
    end
  end

  describe '#update_status!' do
    let(:step) { described_class.new('Register', nil) }

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
      end.to raise_error(Onboardable::InvalidComparisonResultError)
    end
  end
end
