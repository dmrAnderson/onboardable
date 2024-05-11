# frozen_string_literal: true

require_relative 'onboardable/utils/navigation'
require_relative 'onboardable/errors'
require_relative 'onboardable/list'
require_relative 'onboardable/list_builder'
require_relative 'onboardable/step'
require_relative 'onboardable/version'

# The Onboardable module provides a DSL for defining and navigating through a list of steps.
module Onboardable
  # This method is called when the Onboardable module is included in a class.
  #
  # @param klass [Class] the class that is including the Onboardable module
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  # Class methods that are added to the class that includes the Onboardable module.
  module ClassMethods
    # Returns the ListBuilder for the class.
    #
    # @return [ListBuilder] the ListBuilder for the class
    def list_builder
      @list_builder ||= ListBuilder.new
    end

    # Sets the ListBuilder for the class.
    #
    # @yield [ListBuilder] Gives a block that is evaluated in the context of the ListBuilder.
    def list_builder=(&block)
      list_builder.instance_eval(&block)
    end
    alias has_onboarding list_builder=
  end

  # Instance methods that are added to the instances of the class that includes the Onboardable module.
  module InstanceMethods
    # Returns a List built from the ListBuilder of the class.
    #
    # @param current_step_name [String] the name of the current step
    # @return [List] the List built from the ListBuilder of the class
    def onboarding(current_step_name = nil)
      self.class.list_builder.build!(current_step_name)
    end
  end
end
