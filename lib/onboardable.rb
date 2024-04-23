# frozen_string_literal: true

require_relative 'onboardable/version'
require_relative 'onboardable/errors'
require_relative 'onboardable/utils/warnings'
require_relative 'onboardable/step'
require_relative 'onboardable/step_builder'
require_relative 'onboardable/navigation'
require_relative 'onboardable/list'

module Onboardable
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def steps_builder=(&block)
      steps_builder.instance_eval(&block)
    end
    alias has_onboarding steps_builder=

    def onboarding
      steps_builder.build!
    end

    private

    def steps_builder
      @steps_builder ||= StepsBuilder.new
    end
  end
end
