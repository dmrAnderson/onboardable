# frozen_string_literal: true

RSpec.describe Onboardable::Step do
  subject(:step) { described_class.new(name, status: initial_status) }

  let(:name) { 'Intro' }
  let(:initial_status) { described_class::DEFAULT_STATUS }

  describe '#name' do
    it 'returns the name of the step' do
      expect(step.name).to eq(name)
    end

    it 'returns a string representation including the name and status' do
      expect(step.to_s).to eq("#{name} (#{initial_status})")
    end
  end

  describe '#update_status' do
    context 'when updating status based on comparison result' do
      it 'transitions from pending to current with 0' do
        step.update_status(0) # Assuming initial status is pending
        expect(step).to be_current
      end

      it 'maintains current status with 0' do
        step.status = :current
        step.update_status(0)
        expect(step).to be_current
      end

      it 'transitions from current to completed with -1' do
        step.status = :current
        step.update_status(-1)
        expect(step).to be_completed
      end

      it 'transitions from completed to pending with 1' do
        step.status = :completed
        step.update_status(1)
        expect(step).to be_pending
      end

      it 'raises an error with an invalid comparison result' do
        expect { step.update_status(2) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#status' do
    context 'with the default status' do
      let(:initial_status) { described_class::DEFAULT_STATUS }

      it 'returns the default status' do
        expect(step.status).to eq(initial_status)
      end
    end

    described_class::STATUSES.each do |status|
      context "when status is '#{status}'" do
        let(:initial_status) { status }

        it "is in the '#{status}' state" do
          expect(step).to public_send(:"be_#{status}")
        end
      end
    end

    context 'when attempting to set an invalid status' do
      it 'raises an error' do
        expect { step.status = :invalid }.to raise_error(Onboardable::InvalidStatusError)
      end
    end
  end
end
