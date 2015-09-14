module PostgresDatabase
  #Timeline Crud
  class TimelineStorage
    def initialize(username)
      @username = username
      @conn = DBConnection.new
    end

    def get_all_tweets
      conn = @conn.connect
      user_id = get_user_id
      result = conn.exec("select id, tweet, date_and_time, retweet from tweets where user_id = $1", [user_id])
      conn.close
      result
    end

    def get_user_id
      conn = @conn.connect
      result = conn.exec("select id from users where username = $1", [@username]).field_values('id')[0].to_i
      conn.close
      result
    end

    def insert_follower(following_username)
      conn = @conn.connect
      begin
        user_id = get_user_id
        user_id_following = conn.exec("select id from users where username = $1", [following_username]).field_values('id')[0].to_i
        result = conn.exec("insert into followers values($1, $2)", [user_id, user_id_following])
      rescue StandardError => e
        result = nil
      end
      conn.close
      result
    end

    def get_following_name
      conn = @conn.connect
      user_id = get_user_id
      result = []
      no_of_following = get_no_of_followings(user_id)
      for follow in 0..no_of_following - 1
        id = conn.exec("select follower_id from followers where user_id = $1", [user_id]).field_values('follower_id')[follow].to_i
        result << conn.exec("select username from users where id = $1", [id]).field_values('username')[0].to_s
      end
      conn.close
      result
    end

    private
    def get_no_of_followings(user_id)
      conn = @conn.connect
      result = conn.exec("select count(*) from followers where user_id = $1", [user_id]).field_values('count')[0].to_i
      conn.close
      result
    end
  end
end
