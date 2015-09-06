module TwichBlade
  #user should to login into the system
  class User
    def initialize(username, password)
      @username = username
      @password = password
      @user_storage = PostgresUserStorage.new
    end

    def login
      response = @user_storage.exists?(@username, @password)
      if response == true
        :SUCCESS
      else
        :FAILED
      end
    end

    def get_user_info
      @user_storage.profile_info(@username, @password)
    end

    def tweet(tweet_message, user_id)
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, DEFAULT)",[user_id, tweet_message])
    end

    def re_tweet(user_id, tweet_id)
      id_and_tweet = @conn.exec("select user_id, tweet from tweets where id = $1",[tweet_id])
      username = @conn.exec("select username from users where id = $1",[id_and_tweet.field_values('user_id')[0].to_i])
      @conn.exec("insert into tweets values(DEFAULT, $1, $2, LOCALTIMESTAMP, $3)",[user_id, id_and_tweet.field_values('tweet')[0].to_s, username.field_values('username')[0].to_s])
    end
  end
end
