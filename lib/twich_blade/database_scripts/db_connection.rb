module PostgresDatabase
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
      @host = ENV["host"]
    end

    def connect
      @connection = PG.connect( :dbname => @dbname, :host => @host, :port => 5432 )
    end

    def close
      @connection = PG.close
    end
  end
end
