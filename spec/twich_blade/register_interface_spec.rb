require 'spec_helper'

module TwichBlade
  describe 'register interface' do
    context "validate?" do
      it "should able to validate the username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "asdasasdsasds")
        interface.take_user_input
        expect(interface.validate?).to eq(true)
      end

      it "should able to validate the null username" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("")
        interface.take_user_input
        expect(interface.validate?).to eq(false)
      end

      it "should able to validate the null password" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "")
        interface.take_user_input
        expect(interface.validate?).to eq(false)
      end

      it "should able to validate the password" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "barbar1234")
        interface.take_user_input
        expect(interface.validate?).to eq(true)
      end

      it "should able to validate the username and password length validaiton" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "bar")
        interface.take_user_input
        expect(interface.validate?).to eq(false)
      end

      it "should able to validate the username and password length validaiton" do
        dbname = "test_twichblade"
        interface = RegisterInterface.new(dbname)
        allow(Kernel).to receive(:gets).and_return("foo", "foobar12345")
        interface.take_user_input
        expect(interface.validate?).to eq(true)
      end
    end
  end
end
