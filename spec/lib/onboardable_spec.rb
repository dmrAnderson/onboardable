# frozen_string_literal: true

class Dummy
  include Onboardable
  has_onboarding %w[first_name last_name]
end

RSpec.describe Onboardable do
  describe '.onboarding' do
    subject(:onboarding) { Dummy.onboarding }

    it 'returns an instance of Onboardable::List' do
      expect(onboarding).to be_an_instance_of(Onboardable::List)
    end
  end
end
