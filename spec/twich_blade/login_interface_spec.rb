require 'spec_helper'

module TwichBlade
  describe 'login interface' do
    before(:each) { @login_interface = LoginInterface.new }

    context'display' do
      it 'should be able to call unauthorised user' do
        allow_any_instance_of(LoginInterface).to receive(:take_user_input)
        allow_any_instance_of(User).to receive(:login).and_return(:FAILED)
        expect_any_instance_of(LoginInterface).to receive(:unauthorized_user)
        @login_interface.display
      end

      it 'should be able to call authorised user' do
        allow_any_instance_of(LoginInterface).to receive(:take_user_input)
        allow_any_instance_of(User).to receive(:login).and_return(:SUCCESS)
        expect_any_instance_of(LoginInterface).to receive(:authorized_user)
        @login_interface.display
      end

      it 'should be albe to call connection error message' do
        allow_any_instance_of(LoginInterface).to receive(:take_user_input)
        allow_any_instance_of(User).to receive(:login).and_return(:ERROR)
        expect_any_instance_of(LoginInterface).to receive(:connection_error)
        expect_any_instance_of(LoginInterface).to receive(:display_index_page)
        @login_interface.display
      end
    end
  end
end
