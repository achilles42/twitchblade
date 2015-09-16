module PostgresDatabase
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
      @host = ENV["host"]
    end

    def connect
      begin
        @connection = PG.connect( :dbname => @dbname, :host => @host, :port => 5432 )
      rescue PG::ConnectionBad => e
        :ERROR
      end
    end

    def close
      @connection = PG.close
    end
  end
end
