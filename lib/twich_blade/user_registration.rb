module TwichBlade
  #new user registration
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
      @conn = DBConnection.new("test_twichblade").connection
    end

    def validate?
      response = @conn.exec("select username from users where username = $1 ",[@username])
      response.ntuples != 0 ? false : true
    end

    def register
      if validate?
        @conn.exec("insert into users values(DEFAULT, $1, $2)",[@username, @password]);
      else
        :FAILED
      end
    end
  end
end
