require 'spec_helper'

module TwichBlade
  describe 'login interface' do
    before(:each) { @login_interface = LoginInterface.new }

    it "unauthorised user" do
      allow_any_instance_of(TwichBladeCLI).to receive(:take_user_input)
      allow_any_instance_of(User).to receive(:login).and_return(:FAILED)
      expect_any_instance_of(LoginInterface).to receive(:unauthorized_user)
      @login_interface.display
    end

    it "authorised user" do
      allow_any_instance_of(TwichBladeCLI).to receive(:take_user_input)
      allow_any_instance_of(User).to receive(:login).and_return(:SUCCESS)
      expect_any_instance_of(LoginInterface).to receive(:authorized_user)
      @login_interface.display
    end
  end
end
