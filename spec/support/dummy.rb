# frozen_string_literal: true

class Dummy
  include Onboardable

  has_onboarding do
    step 'Create Account', tooltip: 'Minimum 8 characters.'
    step('Verify Email', Class.new { def self.to_hash = { required: true } })
    step 'Complete Profile' # This step does not include specific action data
    step 'Introduction Tour', description: 'Get to know your new workspace!'
  end
end
