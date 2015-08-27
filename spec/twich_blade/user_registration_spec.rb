require 'spec_helper'

module TwichBlade
  describe 'user registration' do
    before(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
    end

    after(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("delete from users")
    end

    context 'validation' do
      it 'should able to check the availbility of username' do
        username = 'foo1'
        password = 'bar1'
        new_user = UserRegistration.new(username, password)
        expect(new_user.validate?).to eq(false)
      end

      it 'should able to check the availbility of username' do
        username = 'foo4'
        password = 'bar4'
        new_user = UserRegistration.new(username, password)
        expect(new_user.validate?).to eq(true)
      end
    end

    context 'registration' do
      it 'should able to register new user' do
        username = 'foo5'
        password = 'bar5'
        conn = PG.connect(:dbname => 'test_twichblade')
        new_user = UserRegistration.new(username, password)
        response = conn.exec("select username, password from users where username = $1 and password = $2",[username, password])
        expect(new_user.register.ntuples).to eq(response.ntuples)
      end

      it 'should not able to register new user with existing username' do
        username = 'foo3'
        password = 'bar3'
        conn = PG.connect(:dbname => 'test_twichblade')
        new_user = UserRegistration.new(username, password)
        expect(new_user.register).to eq(:FAILED)
      end
    end
  end
end
