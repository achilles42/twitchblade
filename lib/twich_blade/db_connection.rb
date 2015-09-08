module TwichBlade
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
    end

    def connect
      PG.connect(
        :dbname => @dbname)
    end

    def close
      PG.close
    end
  end
end
