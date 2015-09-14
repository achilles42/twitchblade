module PostgresDatabase
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
    end

    def connect
      @connection = PG.connect( :dbname => @dbname )
    end

    def close
      @connection = PG.close
    end
  end
end
