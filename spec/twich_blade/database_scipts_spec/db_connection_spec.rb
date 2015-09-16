require 'spec_helper'

module PostgresDatabase
  describe 'database connection' do
    it 'should check if the connection is established with the database' do
      dbname = ENV["dbname"]
      databaseconnection = DBConnection.new
      expect(databaseconnection.connect).to be_a(PG::Connection)
    end

    it 'should check if the connection is established with the database' do
      dbname = ENV["dbname"]
      databaseconnection = DBConnection.new
      expect(databaseconnection.connect).to be_a(PG::Connection)
    end

    it 'should be able to throw an error when database is not rechable' do
      dbname = "staging_twichblade"
      databaseconnection = DBConnection.new
      expect(databaseconnection.connect).to be(:Error)
    end
  end
end
