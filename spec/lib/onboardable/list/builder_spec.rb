# frozen_string_literal: true

RSpec.describe Onboardable::List::Builder do
  subject(:list_builder) { described_class.new }

  describe '#create_step' do
    let(:step_name) { 'intro' }

    context 'when adding a step' do
      before { list_builder.create_step(step_name) }

      it 'adds the step to the builder' do
        expect(list_builder.steps).to include('intro' => step_name)
      end

      it 'sets the first added step as the current step' do
        expect(list_builder.current_step).to eq(step_name)
      end
    end

    context 'when a step with the same name already exists' do
      let(:second_step_name) { 'intro' }

      before do
        list_builder.create_step(step_name)
        list_builder.create_step(second_step_name)
      end

      it 'warns about overriding the existing step' do
        expect { list_builder.create_step(second_step_name) }
          .to output(/warning: Step `intro` already exists and will be overridden./).to_stderr
      end

      it 'overrides the existing step in the list' do
        expect(list_builder.steps['intro']).to eq(second_step_name)
      end
    end
  end

  describe '#create_step_from' do
    let(:klass) do
      Class.new do
        def self.to_onboarding_step
          Onboardable::Step.new('custom_step')
        end
      end
    end

    before { list_builder.create_step_from(klass) }

    it 'adds a converted step from the class to the steps list' do
      expect(list_builder.steps['custom_step']).to be_a(Onboardable::Step)
    end

    it 'sets the correct name for the converted step' do
      expect(list_builder.steps['custom_step'].name).to eq('custom_step')
    end

    context 'when the class cannot be converted to a Step' do
      let(:invalid_klass) do
        Class.new # does not define `to_onboarding_step`
      end

      it 'raises an UndefinedMethodError due to missing conversion method' do
        expect { list_builder.create_step_from(invalid_klass) }
          .to raise_error(Onboardable::UndefinedMethodError)
      end
    end
  end

  describe '#build' do
    context 'when no steps have been added' do
      it 'raises an EmptyStepsError' do
        expect { list_builder.build }.to raise_error(Onboardable::EmptyStepsError)
      end
    end

    context 'when steps are present' do
      before do
        list_builder.create_step('step1')
        list_builder.create_step('step2')
      end

      it 'builds a list with the first step as the current step' do
        list = list_builder.build
        expect(list.current_step.name).to eq('step1')
      end

      it 'builds a list with the specified current step' do
        list = list_builder.build('step2')
        expect(list.current_step.name).to eq('step2')
      end

      it 'raises an StepError if the specified current step does not exist' do
        expect { list_builder.build('nonexistent') }.to raise_error(Onboardable::StepError)
      end
    end
  end
end
