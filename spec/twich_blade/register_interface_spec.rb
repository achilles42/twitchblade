require 'spec_helper'

module TwichBlade
  describe 'register interface' do
    context "validate?" do
      it "should able to validate the username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo")
        interface.display_user_input
        expect(interface.validate?).to eq(true)
      end

      it "should able to validate the username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("")
        interface.display_user_input
        expect(interface.validate?).to eq(false)
      end

      it "should able to validate the username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "")
        interface.display_user_input
        expect(interface.validate?).to eq(false)
      end

    end
  end
end
