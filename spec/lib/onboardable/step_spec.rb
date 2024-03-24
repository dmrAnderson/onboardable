# frozen_string_literal: true

RSpec.describe Onboardable::Step do
  subject(:step) { described_class.new(name, allow_logs: true) }

  let(:name) { 'Intro' }

  describe '#name' do
    it 'returns the name of the step' do
      expect(step.name).to eq(name)
    end
  end

  describe '#status' do
    context 'when status is the default' do
      it 'returns the default status' do
        expect(step.status).to eq(described_class::DEFAULT_STATUS)
      end

      it 'is in the default status state' do
        expect(step).to public_send("be_#{described_class::DEFAULT_STATUS}")
      end
    end

    described_class::STATUSES.each do |status|
      context "when status is '#{status}'" do
        before { step.public_send(:"#{status}!") }

        it "changes the status to '#{status}'" do
          expect(step.status).to eq(status)
        end

        it "is in the '#{status}' state" do
          expect(step).to public_send(:"be_#{status}")
        end
      end
    end

    context 'when status is not one of the defined statuses' do
      let(:status) { 'invalid' }

      it 'raises an error' do
        expect { step.status = status }.to raise_error(Onboardable::InvalidStatusError)
      end
    end
  end
end
