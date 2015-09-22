module TwichBlade
  #user should be able to access the system
  class User
    def initialize(username, password)
      @username = username
      @password = password
      @user_storage = PostgresDatabase::UserStorage.new
    end

    def login
      response = @user_storage.exists?(@username, @password)
      if response == :ERROR
        :ERROR
      elsif response == true
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
      response = @user_storage.re_tweet(tweet_id, @username)
      if response == :FAILED
        :FAILED
      else
        response
      end
    end

    def register
      if validate?
        @user_storage.register(@username, @password)
      else
        :FAILED
      end
    end

    def validate?
      @user_storage.username_validate(@username)
    end
  end
end
