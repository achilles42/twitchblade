require 'spec_helper'

module TwichBlade
  describe 'user timeline' do
    before(:each) do
      @timeline_interface = TimelineInterface.new
      @conn = PostgresDatabase::DBConnection.new.connect
      @conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      user_id = @conn.exec("select id from users where username = $1", ['foo1']).field_values('id')[0].to_i
      tweets = "tweet message !!!"
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, DEFAULT, $3)", [user_id, tweets, 'foo1'])
      @result = @conn.exec("select id, tweet, date_and_time, retweet from tweets where user_id = $1", [user_id])
    end

    after(:each) do
      @conn.exec("delete from tweets")
      @conn.exec("delete from users")
      @conn.close
    end

    it 'should able to display the timeline' do
      allow_any_instance_of(TimelineInterface).to receive(:display_header).with("View Timeline")
      allow_any_instance_of(TimelineInterface).to receive(:username_validation_and_timeline)
      allow_any_instance_of(TimelineInterface).to receive(:display_index_page)
      @timeline_interface.display
    end

    it 'should able to call username_validation_and_timeline' do
      allow_any_instance_of(TimelineInterface).to receive(:input).and_return("username")
      allow_any_instance_of(Timeline).to receive(:show).and_return(@result)
      expect_any_instance_of(TimelineInterface).to receive(:display_timeline).with(@result)
      @timeline_interface.username_validation_and_timeline
    end
  end
end
