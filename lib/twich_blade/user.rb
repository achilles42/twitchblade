module TwichBlade
  #user should to login into the system
  class User
    def initialize(username, password)
      @username = username
      @password = password
      @user_storage = PostgresDatabase::User.new
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

    def tweet(tweet_message)
      @user_storage.insert_tweet(tweet_message, @username)
    end

    def re_tweet(tweet_id)
      @user_storage.re_tweet(tweet_id, @username)
    end
  end
end
