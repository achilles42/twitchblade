require 'spec_helper'

module TwichBlade
  describe 'user' do
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

    context 'login' do
      it 'should able to login succesfully' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password)
        conn = PG.connect(:dbname => 'test_twichblade')
        response = conn.exec("select username, password from users where username = $1 and password = $2",[username, password])
        expect(user.login.ntuples).to eq(response.ntuples)
      end

      it 'should not able to login succesfully' do
        username = 'foo4'
        password = 'bar4'
        user = User.new(username, password)
        expect(user.login).to eq(:FAILED)
      end
    end
  end
end
