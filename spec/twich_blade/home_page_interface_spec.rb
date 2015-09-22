require 'spec_helper'

module TwichBlade
  describe 'home page interface' do
    before(:each) do
      @home_page_interface = HomePageInterface.new
      @conn = PostgresDatabase::DBConnection.new.connect
    end

    it 'should be able to display the home page menu' do
      dbname = "test_twichblade"
      home_page_interface = HomePageInterface.new
      expect{ home_page_interface.display_home_page }.to output(/  1 My Timeline\n  2 tweet\n  3 Other's  Timeline\n  4 Retweet\n  5 Follow\n  6 My Wall\n  7 logout\nEnter your choice : /).to_stdout
    end

    it 'should be able to display the home page' do
      allow_any_instance_of(HomePageInterface).to receive(:user_info)
      allow_any_instance_of(HomePageInterface).to receive(:display_index_page)
      allow(Kernel).to receive(:gets).and_return("7")
      @home_page_interface.display(@conn.exec("select username, password from users"))
    end

    it 'should be able to call my_timeline method' do
      choice = "1"
      allow_any_instance_of(HomePageInterface).to receive(:my_timeline)
      @home_page_interface.process(choice)
    end

    it 'should be able to call tweet method' do
      choice = "2"
      allow_any_instance_of(HomePageInterface).to receive(:tweet)
      @home_page_interface.process(choice)
    end

    it 'should be able to call others_timeline method' do
      choice = "3"
      allow_any_instance_of(HomePageInterface).to receive(:others_timeline)
      @home_page_interface.process(choice)
    end

    it 'should be able to call re_tweet method' do
      choice = "4"
      allow_any_instance_of(HomePageInterface).to receive(:re_tweet)
      @home_page_interface.process(choice)
    end

    it 'should be able to call follow method' do
      choice = "5"
      allow_any_instance_of(HomePageInterface).to receive(:follow)
      @home_page_interface.process(choice)
    end

    it 'should be able to call follow method' do
      choice = "6"
      allow_any_instance_of(HomePageInterface).to receive(:my_wall)
      @home_page_interface.process(choice)
    end

    it 'should be able to call follow method' do
      choice = "12"
      allow_any_instance_of(HomePageInterface).to receive(:error_message)
      @home_page_interface.process(choice)
    end

    context 'follow' do
      it 'should give error message when username is invalid' do
        username = 'foo'
        allow_any_instance_of(HomePageInterface).to receive(:input).and_return(username)
        allow_any_instance_of(PostgresDatabase::UserStorage).to receive(:username_validate).with(username).and_return(true)
        expect_any_instance_of(HomePageInterface).to receive(:error_message)
        @home_page_interface.follow
      end

      it 'should give not error message when username is invalid' do
        username = 'foo'
        allow_any_instance_of(HomePageInterface).to receive(:input).and_return(username)
        allow_any_instance_of(PostgresDatabase::UserStorage).to receive(:username_validate).with(username).and_return(false)
        allow_any_instance_of(Timeline).to receive(:follow).with(username).and_return(nil)
        expect_any_instance_of(HomePageInterface).to receive(:follow_status).with(nil, username)
        @home_page_interface.follow
      end
    end

    it 'should display my Timeline' do
      allow_any_instance_of(HomePageInterface).to receive(:print_timeline)
      tweet = "this is tweet"
      allow_any_instance_of(Timeline).to receive(:show).and_return(tweet)
      expect_any_instance_of(TimelineInterface).to receive(:display_timeline).with(tweet)
      @home_page_interface.my_timeline
    end
  end
end
