# frozen_string_literal: true

require_relative 'onboardable/version'
require_relative 'onboardable/errors'
require_relative 'onboardable/utils/warnings'
require_relative 'onboardable/step'
require_relative 'onboardable/navigation'
require_relative 'onboardable/list'

module Onboardable
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def has_onboarding(steps)
      const_set(:ONBOARDABLE_STEPS, steps.freeze)
    end
  end

  def onboarding
    @onboarding ||= Onboardable::List.new(self.class.const_get(:ONBOARDABLE_STEPS))
  end
end
