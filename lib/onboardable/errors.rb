# frozen_string_literal: true

module Onboardable
  class Error < StandardError; end
  class InvalidStatusError < StandardError; end
  class InvalidTransitionError < StandardError; end
end
