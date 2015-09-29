module PostgresDatabase
  #database connection
  class DBConnection
    def initialize
      @dbname, @host, @port, @dbuser, @dbpassword = ENV["dbname"], ENV["host"], ENV["port"], ENV["dbuser"], ENV["dbpassword"]
    end

    def connect
      begin
        @connection = PG.connect( :dbname => @dbname, :host => @host, :port => @port, :user => @dbuser, :password => @dbpassword)
      rescue PG::ConnectionBad => e
        :ERROR
      end
    end

    def close
      @connection.close
    end
  end
end
