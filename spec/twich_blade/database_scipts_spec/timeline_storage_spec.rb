require 'spec_helper'

module PostgresDatabase
  describe 'timeline storage' do
    before(:each) do
      @conn = DBConnection.new.connect
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
      user_id = @conn.exec("select id from users where username = $1",['foo1']).field_values('id')[0].to_i
      message1 = "this is 1st tweet"
      message2 = "this is 2nd tweet"
      message3 = "this is 3rd tweet"
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, message1])
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, message2])
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, message3])
    end

    after(:each) do
      @conn.exec("delete from tweets")
      @conn.exec("delete from users")
      @conn.close
    end

    it 'should return user id' do
      username = 'foo1'
      user_id = @conn.exec("select * from users where username = $1",[username]).field_values('id')[0].to_i
      timeline_storage = TimelineStorage.new
      expect(timeline_storage.user_id(username)).to eq(user_id)
    end
  end
end
