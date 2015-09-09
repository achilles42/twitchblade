module PostgresDatabase
  #user CRUD
  class UserStorage
    def initialize
      @conn = DBConnection.new
    end

    def exists?(username, password)
      response = profile_info(username, password)
      response.ntuples != 1 ? false : true
    end

    def profile_info(username, password)
      conn = @conn.connect
      result = conn.exec("select id, username, password from users where username = $1 and password = $2",[username, password])
      conn.close
      result
    end

    def insert_tweet(message, username)
      conn = @conn.connect
      user_id = get_user_id_by_user_name(username)
      result = conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, message, username])
      conn.close
      result
    end

    def re_tweet(tweet_id, username)
      conn = @conn.connect
      user_id = get_user_id_by_user_name(username)
      id_tweet_retweet = conn.exec("select user_id, tweet, retweet from tweets where id = $1",[tweet_id])
      result = conn.exec("insert into tweets values (DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, id_tweet_retweet.field_values('tweet')[0].to_s, id_tweet_retweet.field_values('retweet')[0].to_s])
      conn.close
      result
    end

    def username_validate(username)
      conn = @conn.connect
      result = conn.exec("select username from users where username = $1 ",[username])
      conn.close
      result
    end

    def register(username, password)
      conn = @conn.connect
      result = conn.exec("insert into users values(DEFAULT, $1, $2)",[username, password]);
      conn.close
      result
    end

    private
    def get_user_id_by_user_name(username)
      conn = @conn.connect
      result = conn.exec("select id from users where username = $1",[username]).field_values('id')[0].to_i
      conn.close
      result
    end
  end
end
