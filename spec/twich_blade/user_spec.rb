require 'spec_helper'

module TwichBlade
  describe 'user' do
    before(:each) do
      @conn = PG.connect(:dbname => 'test_twichblade')
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
    end

    after(:each) do
      @conn.exec("delete from tweets")
      @conn.exec("delete from users")
      @conn.close
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
      it 'should able to tweet' do
        username = 'foo1'
        password = 'bar1'
        tweet_message = 'C42 engineering it is...'
        user = User.new(username, password)
        user.login
        response = user.tweet(tweet_message)
        expect(response.cmd_tuples).to eq(1)
      end
    end

    context 'retweet' do
      pending 'should able to retweet' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password)
        user.login
        expect(user.re_tweet(response.field_values('id')[0].to_i, tweet_id)).to eq(1)
      end
    end

    context 'validate' do
      it 'should validate the username existance' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password)
        expect(user.validate?).to eq(false)
      end

      it 'should validate the username existnace' do
        username = 'foo5'
        password = 'bar1'
        user = User.new(username, password)
        expect(user.validate?).to eq(true)
      end
    end

    context 'registration' do
      it 'should able to register new user' do
        username = 'foo5'
        password = 'bar5'
        new_user = User.new(username, password)
        response = @conn.exec("select username, password from users where username = $1 and password = $2",[username, password])
        expect(new_user.register.ntuples).to eq(response.ntuples)
      end

      it 'should not able to register new user with existing username' do
        username = 'foo3'
        password = 'bar3'
        new_user = User.new(username, password)
        expect(new_user.register).to eq(:FAILED)
      end
    end
  end
end
