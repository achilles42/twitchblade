module TwichBlade

  class RegisteredUser
    def initialize(username)
      @username = username
      connect
    end

    def exists?
      response = @conn.exec("select username from users where username = '#{@username}'")
      response.ntuples != 0 ? true : false
    end

    private
    def connect
      @conn = PG.connect(
        :dbname => 'test_twichblade')
    end
  end
end
