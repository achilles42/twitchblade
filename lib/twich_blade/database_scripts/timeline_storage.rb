module PostgresDatabase
  #Timeline Crud
  class TimelineStorage
    def initialize(username)
      @username = username
    end

    def get_all_tweets
      conn = connect
      return :ERROR if conn == :ERROR
      user_id = get_user_id
      result = conn.exec("select id, tweet, date_and_time, retweet from tweets where user_id = $1", [user_id])
      conn.close
      result
    end

    def get_user_id
      conn = connect
      return :ERROR if conn == :ERROR
      result = conn.exec("select id from users where username = $1", [@username]).field_values('id')[0].to_i
      conn.close
      result
    end

    def insert_follower(following_username)
      conn = connect
      return :ERROR if conn == :ERROR
      begin
        user_id = get_user_id
        user_id_following = conn.exec("select id from users where username = $1", [following_username]).field_values('id')[0].to_i
        result = conn.exec("insert into followers values($1, $2)", [user_id, user_id_following])
      rescue PG::UniqueViolation => e
        result = nil
      end
      conn.close
      result
    end

    def get_following_name
      conn = connect
      return :ERROR if conn == :ERROR
      user_id = get_user_id
      no_of_following = get_no_of_followings(user_id)
      result = followings_username(no_of_following, user_id, conn)
      conn.close
      result
    end

    def followings_username(no_of_following, user_id, conn)
      result = []
      for follow in 0..no_of_following - 1
        id = conn.exec("select follower_id from followers where user_id = $1", [user_id]).field_values('follower_id')[follow].to_i
        result << conn.exec("select username from users where id = $1", [id]).field_values('username')[0].to_s
      end
      result
    end

    def get_no_of_followings(user_id)
      conn = connect
      return :ERROR if conn == :ERROR
      result = conn.exec("select count(*) from followers where user_id = $1", [user_id]).field_values('count')[0].to_i
      conn.close
      result
    end

    private
    def connect
      conn = DBConnection.new.connect
      return :ERROR if conn == :ERROR
      conn
    end
  end
end
