# frozen_string_literal: true

require_relative 'onboardable/version'
require_relative 'onboardable/errors'
require_relative 'onboardable/list'
require_relative 'onboardable/step'

module Onboardable
  # class Base
  #   class << self
  #     def call(list, _current_step = nil)
  #       List[*list]
  #     end
  #   end
  #
  #   attr_reader :list
  #
  #   def initialize(raw_list, raw_current_step)
  #     @list = List[*raw_list]
  #     @current_step = raw_current_step
  #   end
  #   private_class_method :new
  # end
end
