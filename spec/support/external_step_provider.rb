# frozen_string_literal: true

class ExternalStepProvider
  def self.to_onboarding_step
    Onboardable::Step.new('external_step', info: 'This is an external step.')
  end
end
