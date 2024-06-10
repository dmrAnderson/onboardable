# frozen_string_literal: true

require_relative '../support/dummy'

RSpec.describe Onboardable do
  describe '.onboarding' do
    subject(:dummy) { Dummy }

    it 'returns an instance of Onboardable::List' do
      expect(dummy.onboarding).to be_an_instance_of(Onboardable::List::Base)
    end

    it 'sets the progress calculation' do
      options = dummy.onboarding.instance_variable_get(:@options)
      expect(options).to include(progress_calculation: Dummy::PROGRESS_CALCULATION)
    end

    it 'rejects the dummy step' do
      expect(dummy.onboarding.steps).not_to include(Dummy::STEP)
    end
  end

  describe '#onboarding' do
    subject(:dummy) { Dummy.new }

    it 'returns an instance of Onboardable::List' do
      expect(dummy.onboarding).to be_an_instance_of(Onboardable::List::Base)
    end
  end
end
