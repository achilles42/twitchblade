require 'spec_helper'

module TwichBlade
  describe 'user storage' do
    before(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
    end

    after(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("delete from users")
      conn.close
    end

    it 'should able to return info of logged in user' do
      conn = PG.connect(:dbname => 'test_twichblade')
      username = "foo1"
      password = "bar1"
      response = conn.exec("select id, username, password from users where username = $1 and password = $2",[username, password])
      user_storage = PostgresUserStorage.new
      expect(user_storage.profile_info(username, password).ntuples).to eq(response.ntuples)
    end

    it 'should able to to check the user existance of valid user' do
      conn = PG.connect(:dbname => 'test_twichblade')
      username = "foo1"
      password = "bar1"
      user_storage = PostgresUserStorage.new
      expect(user_storage.exists?(username, password)).to eq(true)
    end

    it 'should able to to check the user existance of invalid user' do
      conn = PG.connect(:dbname => 'test_twichblade')
      username = "foo4"
      password = "bar1"
      user_storage = PostgresUserStorage.new
      expect(user_storage.exists?(username, password)).to eq(false)
    end
  end
end