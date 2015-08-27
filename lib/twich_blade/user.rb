module TwichBlade
  #user should to login into the system
  class User
    def initialize(username, password)
      @username = username
      @password = password
      @conn = DBConnection.new("test_twichblade").connection
    end

    def login
      response = @conn.exec("select username, password from users where username = $1 and password = $2",[@username, @password])
      if response.ntuples != 1
        :FAILED
      else
        :SUCCESS
      end
    end
  end
end