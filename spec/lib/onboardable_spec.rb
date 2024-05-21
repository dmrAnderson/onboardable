# frozen_string_literal: true

require_relative '../support/dummy'

RSpec.describe Onboardable do
  describe '.onboarding' do
    subject(:dummy) { Dummy }

    it 'returns an instance of Onboardable::List' do
      expect(dummy.onboarding).to be_an_instance_of(Onboardable::List::Base)
    end
  end

  describe '#onboarding' do
    subject(:dummy) { Dummy.new }

    it 'returns an instance of Onboardable::List' do
      expect(dummy.onboarding).to be_an_instance_of(Onboardable::List::Base)
    end
  end
end
