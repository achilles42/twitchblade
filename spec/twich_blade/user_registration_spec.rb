require 'spec_helper'

module TwichBlade
  describe 'user registration' do
    context 'validation' do
      it 'should able to validate the user credentials' do
        username = "foo"
        password = "bar"
        user_registration = UserRegistration.new(username, password)
        expect(user_registration.validate?).to eq(true)
      end
    end
  end
end
