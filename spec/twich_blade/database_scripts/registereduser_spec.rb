require 'spec_helper'

module TwichBlade
  describe 'user registration' do
    before { @conn = PG.connect(:dbname => 'test_twichblade') }
    before { @conn.exec("delete from users") }

    it 'should check the availibility of username' do
      username = "foo"
      password = "bar"
      registered_user = RegisteredUser.new(username, password)
      expect(registered_user.exists?).to eq(false)
    end

    it 'should able to add new user in user table' do
      username = "foo"
      password = "bar"
      registered_user = RegisteredUser.new(username, password)
      registered_user.add
      response = @conn.exec("select (username, password) from users where username = '#{username}' and password = '#{password}'")
      expect(response.ntuples).to eq(1)
    end
  end
end
