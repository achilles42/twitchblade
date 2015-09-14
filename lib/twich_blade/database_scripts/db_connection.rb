module PostgresDatabase
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
    end

    def connect
      @connection = PG.connect( :dbname => @dbname, :host => "10.1.1.33", :port => 5432 )
    end

    def close
      @connection = PG.close
    end
  end
end
