module TwichBlade
  #show the timeline of registred users
  class Timeline
    def initialize(username)
      @username = username
      @timeline_storage = PostgresDatabase::TimelineStorage.new
    end

    def show
      user_id = get_user_id
      user_id != 0 ? @timeline_storage.get_all_tweets(@username) : false
    end

    def get_user_id
      @timeline_storage.user_id(@username)
    end
  end
end
