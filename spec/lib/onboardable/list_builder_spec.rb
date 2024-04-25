# frozen_string_literal: true

RSpec.describe Onboardable::ListBuilder do
  subject(:list_builder) { described_class.new }

  describe '#add_step' do
    let(:step_name) { 'intro' }

    it 'adds a step to the list' do
      list_builder.add_step(step_name)
      expect(list_builder.steps.keys).to include(step_name)
    end

    it 'sets the correct step name' do
      list_builder.add_step(step_name)
      expect(list_builder.steps[step_name].name).to eq(step_name)
    end

    it 'sets the first added step as the current step' do
      list_builder.add_step(step_name)
      expect(list_builder.current_step.name).to eq(step_name)
    end

    context 'when adding multiple steps' do
      let(:second_step_name) { 'details' }

      before do
        list_builder.add_step(step_name)
        list_builder.add_step(second_step_name)
      end

      it 'does not change the current step when more steps are added' do
        expect(list_builder.current_step.name).to eq(step_name)
      end
    end
  end

  describe '#build!' do
    context 'when no steps have been added' do
      it 'raises an EmptyListError' do
        expect { list_builder.build!(nil) }.to raise_error(Onboardable::EmptyListError)
      end
    end

    context 'when steps are present' do
      before do
        list_builder.add_step('step1')
        list_builder.add_step('step2')
      end

      it 'builds a list with the specified current step' do
        list = list_builder.build!('step2')
        expect(list.current_step.name).to eq('step2')
      end

      it 'raises an InvalidStepError if the specified current step does not exist' do
        expect { list_builder.build!('nonexistent') }.to raise_error(Onboardable::InvalidStepError)
      end
    end
  end
end
