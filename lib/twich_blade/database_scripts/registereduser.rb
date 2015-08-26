module TwichBlade
  class RegisteredUser
    def initialize(username)
      @username = username
      connect
    end

    def exists?
      false
    end

    private
    def connect
      @conn = PG.connect(
        :dbname => 'test_twichblade')
    end
  end
end
