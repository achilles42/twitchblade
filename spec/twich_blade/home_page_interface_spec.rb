require 'spec_helper'

module TwichBlade
  describe 'home page interface' do
    it 'should able to display the home page menu' do
      dbname = "test_twichblade"
      home_page_interface = HomePageInterface.new
      expect{ home_page_interface.display_home_page }.to output(/  1 My Timeline\n  2 tweet\n  3 Other's  Timeline\n  4 Retweet\n  5 Follow\n  6 logout\nEnter your choice : /).to_stdout
    end
  end
end
