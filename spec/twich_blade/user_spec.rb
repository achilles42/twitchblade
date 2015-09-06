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
        user = User.new(username, password)
        expect(user.login).to eq(:SUCCESS)
      end

      it 'should not able to login succesfully' do
        username = 'foo4'
        password = 'bar4'
        user = User.new(username, password)
        expect(user.login).to eq(:FAILED)
      end
    end

    context 'tweet' do
      pending 'should able to tweet' do
        username = 'foo1'
        password = 'bar1'
        tweet_message = 'C42 engineering it is...'
        user = User.new(username, password)
        response = user.login
        conn = PG.connect(:dbname => 'test_twichblade')
        response = user.tweet(tweet_message, response.field_values('id')[0].to_i)
        expect(response.cmd_tuples).to eq(1)
      end
    end

    context 'retweet' do
      pending 'should able to retweet' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password)
        response = user.login
        conn = PG.connect(:dbname => 'test_twichblade')
        expect(user.re_tweet(response.field_values('id')[0].to_i, tweet_id)).to eq(1)
      end
    end
  end
end
