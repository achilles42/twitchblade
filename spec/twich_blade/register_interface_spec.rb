require 'spec_helper'

module TwichBlade
  describe 'register interface' do
    context "validate?" do
      it "should able to validate the username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "asdasasdsasds")
        interface.display_user_input
        expect(interface.validate?).to eq(true)
      end

      it "should able to validate the null username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("")
        interface.display_user_input
        expect(interface.validate?).to eq(false)
      end

      it "should able to validate the null password" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "")
        interface.display_user_input
        expect(interface.validate?).to eq(false)
      end

      it "should able to validate the password" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "barbar1234")
        interface.display_user_input
        expect(interface.validate?).to eq(true)
      end

      it "should able to validate the username and password length validaiton" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "bar")
        interface.display_user_input
        expect(interface.validate?).to eq(false)
      end
    end
  end
end
