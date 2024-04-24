# frozen_string_literal: true

require_relative 'onboardable/version'
require_relative 'onboardable/errors'
require_relative 'onboardable/step'
require_relative 'onboardable/list_builder'
require_relative 'onboardable/list'

module Onboardable
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def list_builder=(&block)
      list_builder.instance_eval(&block)
    end
    alias has_onboarding list_builder=

    def onboarding
      list_builder.build!
    end

    private

    def list_builder
      @list_builder ||= ListBuilder.new
    end
  end
end
