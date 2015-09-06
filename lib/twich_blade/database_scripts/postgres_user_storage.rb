module TwichBlade
  #user crud
  class PostgresUserStorage
    def initialize
      @conn = DBConnection.new.connection
    end

    def exists?(username, password)
      response = profile_info(username, password)
      response.ntuples != 1 ? false : true
    end

    def profile_info(username, password)
      @conn.exec("select id, username, password from users where username = $1 and password = $2",[username, password])
    end
  end
end
