require 'spec_helper'

module TwichBlade
  describe 'user' do
    before(:each) do
      @conn = PG.connect(:dbname => 'test_twichblade')
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
      @response1 = @conn.exec("select id from users where username = $1", ['foo1'])
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'password')")
      @response2 = @conn.exec("select id from users where username = $1", ['foo2'])
      tweet_message1 = "this is C42 Engineering's tweet 1"
      tweet_message2 = "this is C42 Engineering's tweet 2"
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, $3)", [@response1.field_values('id')[0].to_i, tweet_message1, 'foo1'])
      @tweet_id1 = @conn.exec("select id from tweets where user_id = $1", [@response1.field_values('id')[0].to_i]).field_values('id')[0].to_i
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, $3)", [@response1.field_values('id')[0].to_i, tweet_message2, 'foo1'])
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
      it 'should be able to tweet with tweet lenght size <= 140 char' do
        username = 'foo1'
        password = 'bar1'
        tweet_message = 'C42 engineering it is...'
        user = User.new(username, password)
        user.login
        expect(user.tweet(tweet_message)).to eq(:SUCCESS)
      end

      it 'should not be able to tweet with tweet lenght size > 140' do
        username = 'foo1'
        password = 'bar1'
        tweet_message = 'TwichBlade is an commandline social networking service that enables users to send and read short 140-character messages called tweets thisdfsdfsdfsdfsdfsdfsdfsfsfsdfsfffffff'
        user = User.new(username, password)
        user.login
        expect(user.tweet(tweet_message)).to eq(:FAILED)
      end
    end

    context 'retweet' do
      it 'should be able to retweet' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password)
        user.login
        id_tweet_retweet = @conn.exec("select user_id, tweet, retweet from tweets where id = $1", [@tweet_id1])
        result = @conn.exec("insert into tweets values (DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[@response1.field_values('id')[0].to_i, id_tweet_retweet.field_values('tweet')[0].to_s, id_tweet_retweet.field_values('retweet')[0].to_s])
        expect(user.re_tweet(@tweet_id1).cmd_tuples).to eq(result.cmd_tuples)
      end

      it 'should not be able to retweet' do
        username = 'foo1'
        password = 'bar1'
        user = User.new(username, password)
        user.login
        id_tweet_retweet = @conn.exec("select user_id, tweet, retweet from tweets where id = $1", [@tweet_id])
        result = @conn.exec("insert into tweets values (DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[@response1.field_values('id')[0].to_i, id_tweet_retweet.field_values('tweet')[0].to_s, id_tweet_retweet.field_values('retweet')[0].to_s])
        expect(user.re_tweet(@tweet_id)).to eq(:FAILED)
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

    it 'should be able to get user information' do
      username = 'foo3'
      password = 'bar3'
      new_user = User.new(username, password)
      expect(new_user.get_user_info).to eq(username)
    end
  end
end
