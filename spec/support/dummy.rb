# frozen_string_literal: true

require_relative 'external_step_provider'

class Dummy
  include Onboardable

  has_onboarding do
    step 'welcome', { message: 'Welcome to your new account!' }
    step 'account_setup', { task: 'Create credentials' }
    step 'profile_completion', { task: 'Add a photo and bio' }
    step 'confirmation', { prompt: 'Confirm your details' }
    step_from ExternalStepProvider
  end
end
