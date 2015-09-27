require 'spec_helper'

module PostgresDatabase
  describe 'database connection' do
    it 'should check if the connection is established with the database' do
      database_connection = DBConnection.new
      expect(database_connection.connect).to be_a(PG::Connection)
    end

    it 'should check if the connection is established with the database' do
      database_connection = DBConnection.new
      expect(database_connection.connect).to be_a(PG::Connection)
    end
  end
end
