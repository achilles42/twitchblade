module TwichBlade
  #user should to login into the system
  class User
    def initialize(username, password, dbname)
      @username = username
      @password = password
      @conn = DBConnection.new(dbname).connection
    end

    def login
      @response = @conn.exec("select id, username, password from users where username = $1 and password = $2",[@username, @password])
      if @response.ntuples != 1
        :FAILED
      else
        @response
      end
    end

    def tweet(tweet_message, user_info)
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP)",[user_info.field_values('id')[0].to_i, tweet_message])
    end
  end
end
