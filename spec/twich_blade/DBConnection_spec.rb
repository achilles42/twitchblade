require 'spec_helper'

module TwichBlade
  describe 'DBConnection' do
    it "should check if the connection is established with the database" do
      dbname = "test_twichblade"
      dbconnection = DBConnection.new(dbname)
      expect(dbconnection.connection).to be_a(PG::Connection)
    end
  end
end
