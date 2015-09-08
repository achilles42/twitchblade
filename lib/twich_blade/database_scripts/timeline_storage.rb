module PostgresDatabase
  #timeline crud
  class TimelineStorage
    def initialize
      @conn = PostgresDatabase::DBConnection.new
    end

    def get_all_tweets(username)
      conn = @conn.connect
      user_id = user_id(username)
      result = conn.exec("select id, tweet, date_and_time, retweet from tweets where user_id = $1",[user_id])
      conn.close
      result
    end

    def user_id(username)
      conn = @conn.connect
      result = conn.exec("select id from users where username = $1",[username]).field_values('id')[0].to_i
      conn.close
      result
    end
  end
end
