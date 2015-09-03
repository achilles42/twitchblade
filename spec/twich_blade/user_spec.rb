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
      conn.exec("delete from tweets")
      conn.exec("delete from users")
      conn.close
    end

    context 'login' do
      it 'should able to login succesfully' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password, "test_twichblade")
        conn = PG.connect(:dbname => 'test_twichblade')
        response = conn.exec("select username, password from users where username = $1 and password = $2",[username, password])
        expect(user.login.ntuples).to eq(response.ntuples)
        conn.close
      end

      it 'should not able to login succesfully' do
        username = 'foo4'
        password = 'bar4'
        user = User.new(username, password, "test_twichblade")
        expect(user.login).to eq(:FAILED)
      end
    end

    context 'tweet' do
      it 'should able to tweet' do
        username = 'foo1'
        password = 'bar1'
        tweet_message = 'C42 engineering it is...'
        user_registration = User.new(username, password, "test_twichblade")
        response = user_registration.login
        conn = PG.connect(:dbname => 'test_twichblade')
        result = conn.exec("select * from tweets where tweet = $1",[tweet_message])
        expect(user_registration.tweet(tweet_message, response.field_values('id')[0].to_i).ntuples).to eq(result.ntuples)
        conn.close
      end
    end
  end
end
