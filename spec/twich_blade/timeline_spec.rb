require 'spec_helper'

module TwichBlade
  describe 'timeline' do
    before(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'password')")
      response1 = conn.exec("select id from users where username = $1",['foo1'])
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'password')")
      response2 = conn.exec("select id from users where username = $1",['foo2'])
      tweet_message1 = "this is C42 Engineering tweet's 1"
      tweet_message2 = "this is C42 Engineering tweet's 2"
      conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP)",[response1.field_values('id')[0].to_i, tweet_message1])
      conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP)",[response1.field_values('id')[0].to_i, tweet_message2])
    end

    after(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("delete from tweets")
      conn.exec("delete from users")
      conn.close
    end

    it 'it should able to show the time line of regsitered users' do
      username = "foo1"
      timeline = Timeline.new(username, "test_twichblade")
      conn = PG.connect(:dbname => 'test_twichblade')
      user_id = conn.exec("select id from users where username = $1",[username])
      response = conn.exec("select id, tweet, data_and_time from tweets where user_id = $1",[user_id.field_values('id')[0].to_i])
      expect(timeline.show.ntuples).to eq(response.ntuples)
      conn.close
    end
  end
end
