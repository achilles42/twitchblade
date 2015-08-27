module TwichBlade
  #new user registration
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
      @conn = DBConnection.new("test_twichblade")
    end

    def validate?
      conn = @conn.connection
      response = conn.exec("select username from users where username = $1 ",[@username])
      response.ntuples != 0 ? false : true
     end
  end
end
