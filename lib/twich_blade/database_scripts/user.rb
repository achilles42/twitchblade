module PostgresDatabase
  #user CRUD
  class User
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
      result = conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, message])
      conn.close
      result
    end

    def re_tweet(tweet_id, username)
      conn = @conn.connect
      user_id = get_user_id_by_user_name(username)
      id_and_tweet = conn.exec("select user_id, tweet from tweets where id = $1",[tweet_id])
      username = conn.exec("select id,username from users where id = $1",[id_and_tweet.field_values('user_id')[0].to_i]).field_values('username')[0].to_s
      result = conn.exec("insert into tweets values (DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, id_and_tweet.field_values('tweet')[0].to_s, username])
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
