module TwichBlade
  #inserting non-existing user into database
  class RegisteredUser
    def initialize(username, password)
      @username = username
      @password = password
      connect
    end

    def exists?
      response = @conn.exec("select username from users where username = '#{@username}'")
      response.ntuples != 0 ? true : false
    end

    def add
      @conn.exec("insert into users (username, password) values('#{@username}', '#{@password}')")
    end

    private
    def connect
      @conn = PG.connect(
        :dbname => 'test_twichblade')
    end
  end
end
