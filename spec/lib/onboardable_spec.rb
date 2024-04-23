# frozen_string_literal: true

RSpec.describe Onboardable do
  describe '.onboarding' do
    subject(:dummy) do
      Class.new do
        include Onboardable

        has_onboarding do
          step 'First Name', Data.define
          step 'Second Name'
          step 'Last Name', Data.define
        end
      end
    end

    it 'returns an instance of Onboardable::List' do
      expect(dummy.onboarding).to be_an_instance_of(Onboardable::List)
    end
  end
end
