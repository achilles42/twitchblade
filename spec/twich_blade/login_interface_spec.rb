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

    it 'should be able to unauthorize the user' do
      allow_any_instance_of(LoginInterface).to receive(:display_error_message)
      allow_any_instance_of(LoginInterface).to receive(:display_index_page)
      @login_interface.unauthorized_user
    end

    context 'authorised user' do
      it 'should be able to call connection error' do
        allow_any_instance_of(User).to receive(:get_user_info).and_return(:ERROR)
        expect_any_instance_of(LoginInterface).to receive(:connection_error)
        allow_any_instance_of(LoginInterface).to receive(:display_index_page)
        @login_interface.authorized_user
      end

      it 'should be able to display home page' do
        username = "foo"
        allow_any_instance_of(User).to receive(:get_user_info).and_return(username)
        expect_any_instance_of(LoginInterface).to receive(:welcome_message).with(username)
        allow_any_instance_of(HomePageInterface).to receive(:display).with(username)
        @login_interface.authorized_user
      end
    end
  end
end
