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
  # @param klass [Module] The class including the Onboardable module
  # @return [void]
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  # Class methods for managing the onboarding process, added to the class that includes the Onboardable module.
  module ClassMethods
    # @return [List::Builder] The ListBuilder for configuring onboarding steps.
    attr_accessor :list_builder

    # Configures onboarding steps via a ListBuilder with a provided block.
    #
    # @param options [Hash] Optional configuration options for the ListBuilder.
    # @option options [Proc] :progress_calculation A custom calculation for progress percentage.
    #   Receives step_index and steps_size as arguments and returns a Float.
    # @yield [List::Builder] Executes block in the context of List::Builder.
    # @return [Step] The current step in the building process.
    def onboarding=(options = {}, &)
      self.list_builder = List::Builder.new(options)
      list_builder.instance_eval(&)
    end
    alias has_onboarding onboarding=

    # Builds the onboarding list and optionally sets the current step.
    #
    # @param current_step_name [String, nil] The name of the current step, if specified.
    # @return [List::Base] The List built from the class's ListBuilder.
    def onboarding(current_step_name = nil)
      list_builder.build(current_step_name)
    end
  end

  # Instance methods for onboarding navigation, added to classes including Onboardable.
  module InstanceMethods
    # Builds the onboarding list and optionally sets the current step.
    #
    # @param current_step_name [String, nil] The name of the current step, if specified.
    # @return [List::Base] The List built from the class's ListBuilder.
    def onboarding(current_step_name = nil)
      self.class.onboarding(current_step_name)
    end
  end
end
