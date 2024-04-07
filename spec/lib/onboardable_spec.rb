# frozen_string_literal: true

# RSpec.describe Onboardable::Base do
#   describe '.call' do
#     subject(:dummy) { described_class.call(steps) }
#
#     let(:raw_steps) { 'nickname address phone_number' }
#
#     context 'without appropriate argument' do
#       alias_method :steps, :raw_steps
#       specify do
#         expect { dummy }.to raise_error(ArgumentError)
#       end
#     end
#
#     context 'with duplicate steps' do
#       let(:steps) { [raw_steps, raw_steps] }
#
#       specify do
#         expect { dummy }.not_to raise_error
#       end
#     end
#
#     context 'with appropriate argument' do
#       let(:steps) { raw_steps.split }
#
#       specify do
#         expect(dummy).to be_an_instance_of(Onboardable::List)
#       end
#     end
#   end
# end
