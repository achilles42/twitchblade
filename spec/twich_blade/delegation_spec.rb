require 'spec_helper'

module TwichBlade
  describe 'delegation' do
    pending 'should show next page to the user as per the input' do
      command = 1
      allow(Kernel).to receive(:gets).and_return("foo1")
      allow(Kernel).to receive(:gets).and_return("bar1")
      delegation = Delegation.new
      expect(delegation.delegate(command)).to eq(:SUCCESS)
    end
  end
end
