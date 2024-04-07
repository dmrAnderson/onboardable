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
  end
end
