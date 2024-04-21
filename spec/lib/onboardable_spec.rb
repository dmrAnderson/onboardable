# frozen_string_literal: true

RSpec.describe Onboardable do
  class Dummy
    include Onboardable
    has_onboarding %w[first_name last_name]
  end

  it 'stores the onboarding steps as a constant in the class' do
    expect(Dummy::ONBOARDABLE_STEPS).to eq(%w[first_name last_name])
  end

  it 'ensures the onboarding steps constant is frozen to prevent modification' do
    expect(Dummy::ONBOARDABLE_STEPS).to be_frozen
  end

  it 'creates an Onboardable::List instance for handling the onboarding process' do
    expect(Dummy.new.onboarding).to be_an_instance_of(Onboardable::List)
  end
end
