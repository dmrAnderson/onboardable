# frozen_string_literal: true

RSpec.describe Onboardable do
  subject(:dummy) { Class.new { include Onboardable } }

  it 'includes the necessary methods' do
    expect(dummy.new).not_to be_nil
  end
end
