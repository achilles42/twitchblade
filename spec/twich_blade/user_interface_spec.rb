require 'spec_helper'

module TwichBlade
  describe 'user interface' do
    context 'input' do
      it 'should able to take input from user' do
        allow(Kernel).to receive(:gets).and_return("twichblade")
        user_interface = UserInterface.new
        expect(user_interface.input).to eq("twichblade")
      end
    end

    it 'should display index page' do
      user_interface = UserInterface.new
      expect{ user_interface.display_index_page }.to output(/-------------------------------\n\tWelcome to TwichBlade\t\n-------------------------------\n\t1   SignUp\n\t2   SignIn\n\t3   Timeline\n\t4   Exit\nEnter your Choice  :/).to_stdout
    end

    it 'should display header page' do
      page = "SignIn"
      user_interface = UserInterface.new
      expect{ user_interface.display_header(page) }.to output(/--------------------------------\n   Welcome to #{page} page\n--------------------------------/).to_stdout
    end

    it 'should able to take input from users' do
      allow(Kernel).to receive(:gets).and_return("username", "password")
      user_interface = UserInterface.new
      expect{ user_interface.take_user_input }.to output(/Enter UserName : Enter Password : /).to_stdout
    end

    it 'should able to print error message' do
      user_interface = UserInterface.new
      expect{ user_interface.error_message }.to output(/\tPlease Enter the correct choice : /).to_stdout
    end
  end
end
