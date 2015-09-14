module TwichBlade
  #show the timeline of registred users
  class Timeline
    def initialize(username)
      @username = username
      @timeline_storage = PostgresDatabase::TimelineStorage.new(username)
    end

    def show
      user_id = get_user_id
      user_id != 0 ? @timeline_storage.get_all_tweets : false
    end

    def get_user_id
      @timeline_storage.get_user_id
    end

    def follow(follower_username)
      @timeline_storage.insert_follower(follower_username)
    end

    def my_wall
      following_list = @timeline_storage.get_following_ids
    end
  end
end
