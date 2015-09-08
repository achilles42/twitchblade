module TwichBlade
  #user should to login into the system
  class User
    def initialize(username, password)
      @username = username
      @password = password
      @user_storage = PostgresDatabase::UserStorage.new
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

    def register
      if validate?
        @user_storage.register(@username, @password)
      else
        :FAILED
      end
    end

    private
    def validate?
      response = @user_storage.username_validate?(@username)
      response.ntuples != 0 ? false : true
    end
  end
end
