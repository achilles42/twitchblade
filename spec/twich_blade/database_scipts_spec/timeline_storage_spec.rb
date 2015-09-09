require 'spec_helper'

module PostgresDatabase
  describe 'timeline storage' do
    before(:each) do
      @conn = DBConnection.new.connect
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
      user_id = @conn.exec("select id from users where username = $1", ['foo1']).field_values('id')[0].to_i
      message1 = "this is 1st tweet"
      message2 = "this is 2nd tweet"
      message3 = "this is 3rd tweet"
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)", [user_id, message1])
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)", [user_id, message2])
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)", [user_id, message3])
    end

    after(:each) do
      @conn.exec("delete from tweets")
      @conn.exec("delete from followers")
      @conn.exec("delete from users")
      @conn.close
    end

    it 'should return user id' do
      username = 'foo1'
      user_id = @conn.exec("select * from users where username = $1", [ username]).field_values('id')[0].to_i
      timeline_storage = TimelineStorage.new(username)
      expect(timeline_storage.get_user_id).to eq(user_id)
    end

    it 'should return all the tweets of particular user' do
      username = 'foo1'
      timeline_storage = TimelineStorage.new(username)
      user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
      result = @conn.exec("select id, tweet, date_and_time, retweet from tweets where user_id = $1",[user_id])
      expect(timeline_storage.get_all_tweets.ntuples).to eq(result.ntuples)
    end

    it 'should able to insert following-follower relationship' do
      username = 'foo1'
      timeline_storage = TimelineStorage.new(username)
      user_id = timeline_storage.get_user_id
      follower_username = 'foo2'
      user_id_follower = @conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
      result = timeline_storage.insert_follower(follower_username)
      expect(result.cmd_tuples).to eq(1)
    end

    it 'should not able to insert following-follower relationship again with same user' do
      username = 'foo1'
      timeline_storage = TimelineStorage.new(username)
      user_id = timeline_storage.get_user_id
      follower_username = 'foo2'
      user_id_follower = @conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
      @conn.exec("insert into followers values($1, $2)", [user_id, user_id_follower])
      result = timeline_storage.insert_follower(follower_username)
      expect(result).to eq(nil)
    end
  end
end
