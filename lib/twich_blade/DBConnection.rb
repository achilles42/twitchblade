module TwichBlade
  #database connection
  class DBConnection
    def initialize(dbname)
      @dbname = dbname
    end

    def connection
      PG.connect(
        :dbname => @dbname)
    end
  end
end
