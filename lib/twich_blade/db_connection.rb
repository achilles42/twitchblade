module TwichBlade
  #database connection
  class DBConnection
    def initialize
      @dbname = ENV["dbname"]
    end

    def connection
      PG.connect(
        :dbname => @dbname)
    end
  end
end
