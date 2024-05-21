# frozen_string_literal: true

require_relative 'onboardable/errors'
require_relative 'onboardable/utils/warnings'
require_relative 'onboardable/list/navigation'
require_relative 'onboardable/list/builder'
require_relative 'onboardable/list/base'
require_relative 'onboardable/step'
require_relative 'onboardable/version'

# The Onboardable module provides a DSL for defining and navigating onboarding steps.
module Onboardable
  # Initializes the Onboardable module when included in a class, extending it with class and instance methods.
  #
  # @param klass [Module] the class including the Onboardable module
  # @return [untyped]
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  # Class methods for managing the onboarding process, added to the class that includes the Onboardable module.
  module ClassMethods
    # Retrieves or initializes a ListBuilder for onboarding steps at the class level.
    #
    # @return [List::Builder] the ListBuilder associated with the class
    def list_builder
      @list_builder ||= List::Builder.new
    end

    # Configures onboarding steps via a ListBuilder with a provided block.
    #
    # @yield [List::Builder] executes block in the context of List::Builder
    # @return [Step] the current step in the building process
    def list_builder=(&block)
      list_builder.instance_eval(&block)
    end
    alias has_onboarding list_builder=

    # Builds the onboarding list and optionally sets the current step.
    #
    # @param current_step_name [String, nil] the name of the current step, if specified
    # @return [List::Base] the List built from the class's ListBuilder
    def onboarding(current_step_name = nil)
      list_builder.build!(current_step_name)
    end
  end

  # Instance methods for onboarding navigation, added to classes including Onboardable.
  module InstanceMethods
    # Builds the onboarding list and optionally sets the current step.
    #
    # @param current_step_name [String, nil] the name of the current step, if specified
    # @return [List::Base] the List built from the class's ListBuilder
    def onboarding(current_step_name = nil)
      self.class.onboarding(current_step_name)
    end
  end
end
