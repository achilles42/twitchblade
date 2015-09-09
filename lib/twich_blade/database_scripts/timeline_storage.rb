module PostgresDatabase
  #Timeline Crud
  require 'pg'
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

    def insert_follower(follower_username)
      conn = @conn.connect
      begin
        user_id = get_user_id
        user_id_follower = conn.exec("select id from users where username = $1", [follower_username]).field_values('id')[0].to_i
        result = conn.exec("insert into followers values($1, $2)", [user_id, user_id_follower])
      rescue StandardError => e
        result = nil
      end
      conn.close
      result
    end
  end
end
