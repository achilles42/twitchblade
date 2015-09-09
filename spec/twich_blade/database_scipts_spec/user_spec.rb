require 'spec_helper'

module PostgresDatabase
  describe 'user storage' do
    before(:each) do
      @conn = @conn = DBConnection.new.connect
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
    end

    after(:each) do
      @conn.exec("delete from tweets")
      @conn.exec("delete from followers")
      @conn.exec("delete from users")
      @conn.close
    end

    it 'should able to return info of logged in user' do
      username = "foo1"
      password = "bar1"
      response = @conn.exec("select id, username, password from users where username = $1 and password = $2",[username, password])
      user_storage = UserStorage.new
      expect(user_storage.profile_info(username, password).ntuples).to eq(response.ntuples)
    end

    it 'should able to to check the user existance of valid user' do
      username = "foo1"
      password = "bar1"
      user_storage = UserStorage.new
      expect(user_storage.exists?(username, password)).to eq(true)
    end

    it 'should able to to check the user existance of invalid user' do
      username = "foo4"
      password = "bar1"
      user_storage = UserStorage.new
      expect(user_storage.exists?(username, password)).to eq(false)
    end

    it 'should able to insert tweet' do
      username = "foo1"
      password = "bar1"
      user = TwichBlade::User.new(username, password).login
      user_storage = UserStorage.new
      message = "this spec tweet!!!"
      tweet = user_storage.insert_tweet(message, username)
      user_id = @conn.exec("select id from users where username = $1",[username]).field_values('id')[0].to_i
      response = @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, message])
      expect(tweet.cmd_tuples).to eq(response.cmd_tuples)
    end

    it 'should able to retweet' do
      username = "foo1"
      password = "bar1"
      user = TwichBlade::User.new(username, password).login
      user_storage = UserStorage.new
      message = "this is spec tweet"
      user_id = @conn.exec("select id from users where username = $1",[username]).field_values('id')[0].to_i
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, message]);
      tweet_id = @conn.exec("select id from tweets where user_id = $1",[user_id]).field_values('id')[0].to_i
      id_and_tweet = @conn.exec("select user_id, tweet from tweets where id = $1",[tweet_id])
      username = @conn.exec("select id,username from users where id = $1",[id_and_tweet.field_values('user_id')[0].to_i]).field_values('username')[0].to_s
      response = @conn.exec("insert into tweets values (DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, id_and_tweet.field_values('tweet')[0].to_s, username])
      re_tweet = user_storage.re_tweet(tweet_id, username)
      expect(re_tweet.cmd_tuples).to eq(response.cmd_tuples)
    end
  end
end
