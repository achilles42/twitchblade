require 'spec_helper'

module TwichBlade
  describe 'user interface' do
    context "input" do
      it "should able to take input from user" do
        allow(Kernel).to receive(:gets).and_return("twichblade")
        user_interface = UserInterface.new("test_twichblade")
        expect(user_interface.input).to eq("twichblade")
      end
    end

    it "display index page" do
      user_interface = UserInterface.new("test_twichblade")
      expect{ user_interface.display_index_page }.to output(/-------------------------------\n\tWelcome to TwichBlade\t\n-------------------------------\n\t1   SignUp\n\t2   SignIn\n\t3   Exit\nEnter your Choice  :/).to_stdout
    end
  end
end
