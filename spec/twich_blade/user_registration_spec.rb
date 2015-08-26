require 'spec_helper'

module TwichBlade
  describe 'user registration' do
    before { @conn = PG.connect(:dbname => 'test_twichblade') }
    before { @conn.exec("delete from users") }

    context 'validation' do
      it 'should able to validate the user credentials' do
        username = "foo"
        password = "bar"
        user_registration = UserRegistration.new(username, password)
        expect(user_registration.validate?).to eq(true)
      end
    end

    it 'should able to register new valid user' do
      username = "foo"
      password = "bar"
      @conn = PG.connect(:dbname => 'test_twichblade')
      user_registration = UserRegistration.new(username, password)
      user_registration.register
      response = @conn.exec("select (username, password) from users where username = '#{username}' and password = '#{password}'")
      expect(response.ntuples).to eq(1)
    end
  end
end
