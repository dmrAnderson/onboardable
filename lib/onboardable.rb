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
    attr_reader :list
    alias onboarding list

    def list=(raw_list)
      @list = List.new(raw_list)
    end
    alias has_onboarding list=
  end
end
