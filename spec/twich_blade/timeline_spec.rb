require 'spec_helper'

module TwichBlade
  describe 'timeline' do
    before(:each) do
      @conn = PostgresDatabase::DBConnection.new.connect
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'password')")
      response1 = @conn.exec("select id from users where username = $1", ['foo1'])
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'password')")
      response2 = @conn.exec("select id from users where username = $1", ['foo2'])
      tweet_message1 = "this is C42 Engineering's tweet 1"
      tweet_message2 = "this is C42 Engineering's tweet 2"
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP)", [response1.field_values('id')[0].to_i, tweet_message1])
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP)", [response1.field_values('id')[0].to_i, tweet_message2])
    end

    after(:each) do
      @conn.exec("delete from tweets")
      @conn.exec("delete from followers")
      @conn.exec("delete from users")
      @conn.close
    end

    context 'display timeline' do
      it 'should be able to show the time line of regsitered users' do
        username = "foo1"
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username])
        response = @conn.exec("select id, tweet, date_and_time from tweets where user_id = $1",[user_id.field_values('id')[0].to_i])
        expect(timeline.show.ntuples).to eq(response.ntuples)
      end

      it 'should be able to show the time line of regsitered users' do
        username = "foo2"
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username])
        response = @conn.exec("select id, tweet, date_and_time from tweets where user_id = $1",[user_id.field_values('id')[0].to_i])
        expect(timeline.show.ntuples).to eq(response.ntuples)
      end
    end

    context 'user id' do
      it 'should be able to return user id of user' do
        username = "foo1"
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
        expect(timeline.get_user_id).to eq(user_id)
      end

      it 'should able to return user id of user' do
        username = "foo2"
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
        expect(timeline.get_user_id).to eq(user_id)
      end
    end

    context 'follow' do
      it 'should be able follow other registred user' do
        username = "foo1"
        follower_username = "foo2"
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
        user_id_follower = @conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
        expect(timeline.follow(follower_username).cmd_tuples).to eq(1)
      end

      it 'should be able follow other registred users' do
        username = "foo2"
        follower_username = "foo1"
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
        user_id_follower = @conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
        expect(timeline.follow(follower_username).cmd_tuples).to eq(1)
      end
    end

    context 'my wall' do
      it 'should be able to display my wall with all my following with username = foo1' do
        username = 'foo1'
        follower_username = 'foo2'
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
        followers_id = @conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
        @conn.exec("insert into followers values($1, $2)", [user_id, followers_id])
        expect(timeline.followings).to eq(['foo2'])
      end

      it 'should be able to display my wall with all my following with username = foo2' do
        username = 'foo2'
        follower_username = 'foo1'
        timeline = Timeline.new(username)
        user_id = @conn.exec("select id from users where username = $1", [username]).field_values('id')[0].to_i
        followers_id = @conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
        @conn.exec("insert into followers values($1, $2)", [user_id, followers_id])
        expect(timeline.followings).to eq(['foo1'])
      end
    end
  end
end
