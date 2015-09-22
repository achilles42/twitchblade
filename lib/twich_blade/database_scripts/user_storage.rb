module PostgresDatabase
  #user CRUD
  class UserStorage
    def initialize
      @conn = DBConnection.new
    end

    def exists?(username, password)
      response = profile_info(username, password)
      if response == :ERROR
        response = :ERROR
      else
        response.is_a?(String) ? true : false
      end
    end

    def profile_info(username, password)
      conn = @conn.connect
      if conn == :ERROR
        result = :ERROR
      else
        result = conn.exec("select username from users where username = $1 and password = $2",[username, password]).field_values('username')[0]
        conn.close
      end
      result
    end

    def insert_tweet(message, username)
      conn = @conn.connect
      if conn == :ERROR
        result = :ERROR
      else
        user_id = get_user_id_by_user_name(username)
        result = conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, message, username])
        conn.close
      end
      result
    end

    def re_tweet(tweet_id, username)
      conn = @conn.connect
      if conn == :ERROR
        result = :ERROR
      else
        user_id = get_user_id_by_user_name(username)
        id_tweet_retweet = conn.exec("select user_id, tweet, retweet from tweets where id = $1",[tweet_id])
        result = conn.exec("insert into tweets values (DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, id_tweet_retweet.field_values('tweet')[0].to_s, id_tweet_retweet.field_values('retweet')[0].to_s])
        if id_tweet_retweet.ntuples == 0
          result = :FAILED
        end
        conn.close
      end
      result
    end

    def username_validate(username)
      conn = @conn.connect
      if conn == :ERROR
        result = :ERROR
      else
        result = conn.exec("select username from users where username = $1 ",[username]).ntuples == 1 ? false : true
        conn.close
      end
      result
    end

    def register(username, password)
      conn = @conn.connect
      if conn == :ERROR
        result = :ERROR
      else
        result = conn.exec("insert into users values(DEFAULT, $1, $2)",[username, password]);
        conn.close
      end
      result
    end

    private
    def get_user_id_by_user_name(username)
      conn = @conn.connect
      if conn == :ERROR
        result = nil
      else
        result = conn.exec("select id from users where username = $1",[username]).field_values('id')[0].to_i
        conn.close
      end
      result
    end
  end
end
