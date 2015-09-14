require 'spec_helper'

module TwichBlade
  describe 'home page interface' do
    before(:each) do
      @home_page_interface = HomePageInterface.new
      @conn = PostgresDatabase::DBConnection.new.connect
    end

    it 'should able to display the home page menu' do
      dbname = "test_twichblade"
      home_page_interface = HomePageInterface.new
      expect{ home_page_interface.display_home_page }.to output(/  1 My Timeline\n  2 tweet\n  3 Other's  Timeline\n  4 Retweet\n  5 Follow\n  6 My Wall\n  7 logout\nEnter your choice : /).to_stdout
    end

    it 'should able to display the home page' do
      allow_any_instance_of(HomePageInterface).to receive(:user_info)
      allow_any_instance_of(HomePageInterface).to receive(:display_index_page)
      allow(Kernel).to receive(:gets).and_return("7")
      @home_page_interface.display(@conn.exec("select username, password from users"))
    end
  end
end
