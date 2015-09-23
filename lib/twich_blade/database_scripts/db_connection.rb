module PostgresDatabase
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
      @host = ENV["host"]
      @port = ENV["port"]
      @dbuser = ENV["dbuser"]
      @dbpassword = ENV["dbpassword"]
    end

    def connect
      begin
        @connection = PG.connect( :dbname => @dbname, :host => @host, :port => @port, :user => @dbuser, :password => @dbpassword)
      rescue PG::ConnectionBad => e
        :ERROR
      end
    end

    def close
      @connection = PG.close
    end
  end
end
