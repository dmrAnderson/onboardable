# frozen_string_literal: true

RSpec.describe Onboardable::ListBuilder do
  subject(:list_builder) { described_class.new }

  let(:step_name) { 'Profile Completion' }
  let(:another_step_name) { 'Email Confirmation' }

  describe '#step=' do
    before { list_builder.add_step(step_name) }

    it 'adds a step with the given name and representation' do
      expect(list_builder.steps[step_name]).to have_attributes(name: step_name)
    end

    it 'sets the first added step as the default current step' do
      expect(list_builder.current_step).to have_attributes(name: step_name)
    end

    it 'does not change the current step when more steps are added' do
      list_builder.add_step(another_step_name)
      expect(list_builder.current_step.name).to eq(step_name)
    end
  end

  describe '#build' do
    before do
      list_builder.add_step(step_name)
      list_builder.add_step(another_step_name)
    end

    context 'with a specified current step name' do
      it 'builds a list with the specified step as current' do
        list = list_builder.build!(another_step_name)
        expect(list.current_step.name).to eq(another_step_name)
      end
    end

    context 'with no current step name provided' do
      it 'builds a list with the default current step' do
        list = list_builder.build!(nil)
        expect(list.current_step.name).to eq(step_name)
      end
    end

    context 'with an invalid step name' do
      it 'raises an error when the specified step name does not exist' do
        expect do
          list_builder.build!('Nonexistent Step')
        end.to raise_error(Onboardable::InvalidStepError)
      end
    end
  end
end
