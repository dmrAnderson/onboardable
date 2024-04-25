# frozen_string_literal: true

require_relative 'onboardable/version'
require_relative 'onboardable/errors'
require_relative 'onboardable/step'
require_relative 'onboardable/list_builder'
require_relative 'onboardable/list'

module Onboardable
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  module ClassMethods
    def list_builder
      @list_builder ||= ListBuilder.new
    end

    def list_builder=(&block)
      list_builder.instance_eval(&block)
    end
    alias has_onboarding list_builder=
  end

  module InstanceMethods
    def onboarding(current_step_name = nil)
      self.class.list_builder.build!(current_step_name)
    end
  end
end
