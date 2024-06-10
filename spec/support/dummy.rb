# frozen_string_literal: true

require_relative 'external_step_provider'

class Dummy
  include Onboardable

  PROGRESS_CALCULATION = ->(step_index, steps_size) { (step_index.to_f / steps_size) * 100 }

  has_onboarding progress_calculation: PROGRESS_CALCULATION do
    step 'welcome', { message: 'Welcome to your new account!' }
    step 'account_setup', { task: 'Create credentials' }
    step 'profile_completion', { task: 'Add a photo and bio' }
    step 'confirmation', { prompt: 'Confirm your details' }
    step_from ExternalStepProvider
  end
end
