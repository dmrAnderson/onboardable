# frozen_string_literal: true

class Dummy
  include Onboardable

  has_onboarding do
    step 'First Name', Class.new
    step 'Second Name'
    step 'Last Name', Class.new
  end
end
