module PostgresDatabase
  #user CRUD
  class UserStorage
    def initialize
      @conn = DBConnection.new
    end

    def exists?(username, password)
      response = profile_info(username, password)
      return :ERROR if response == :ERROR
      response.is_a?(String) ? true : false
    end

    def profile_info(username, password)
      conn = connect
      return :ERROR if conn == :ERROR
      result = conn.exec("select username from users where username = $1 and password = $2",[username, password]).field_values('username')[0]
      conn.close
      result
    end

    def insert_tweet(message, username)
      conn = connect
      return :ERROR if conn == :ERROR
      user_id = get_user_id_by_user_name(username)
      result = conn.exec("insert into tweets values(DEFAULT, $1, $2, $3, $4)",[user_id, message, DateTime.now, username])
      conn.close
      result
    end

    def re_tweet(tweet_id, username)
      conn = connect
      return :ERROR if conn == :ERROR
      user_id = get_user_id_by_user_name(username)
      id_tweet_retweet = conn.exec("select user_id, tweet, retweet from tweets where id = $1",[tweet_id])
      result = conn.exec("insert into tweets values (DEFAULT, $1, $2, $3, $4)",[user_id, id_tweet_retweet.field_values('tweet')[0].to_s, DateTime.now, id_tweet_retweet.field_values('retweet')[0].to_s])
      if id_tweet_retweet.ntuples == 0
        result = :FAILED
      end
      conn.close
      result
    end

    def username_validate(username)
      conn = connect
      return :ERROR if conn == :ERROR
      result = conn.exec("select username from users where username = $1 ",[username]).ntuples == 1 ? false : true
      conn.close
      result
    end

    def register(username, password)
      conn = connect
      return :ERROR if conn == :ERROR
      result = conn.exec("insert into users values(DEFAULT, $1, $2)",[username, password]);
      conn.close
      result
    end

    private
    def get_user_id_by_user_name(username)
      conn = connect
      return :ERROR if conn == :ERROR
      result = conn.exec("select id from users where username = $1",[username]).field_values('id')[0].to_i
      conn.close
      result
    end

    def connect
      conn = @conn.connect
      return :ERROR if conn == :ERROR
      conn
    end
  end
end
