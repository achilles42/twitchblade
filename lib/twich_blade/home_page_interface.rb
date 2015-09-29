module TwichBlade
  #user can see home page
  class HomePageInterface < UserInterface
    def display(user_info)
      @user_info = user_info
      while true
        display_home_page
        choice = input
        if choice == '7'
          break
        else
          process(choice)
        end
      end
      display_index_page
    end

    def display_home_page
      print "  1 My Timeline\n  2 tweet\n  3 Other's  Timeline\n  4 Retweet\n  5 Follow\n  6 My Wall\n  7 logout\nEnter your choice : "
    end

    def process(choice)
      if choice == "1"
        my_timeline
      elsif choice == "2"
        tweet
      elsif choice == "3"
        others_timeline
      elsif choice == "4"
        re_tweet
      elsif choice == "5"
        follow
      elsif choice == "6"
        my_wall
      else
        error_message
      end
    end

    def follow
      print "Enter Username : "
      username = input
      response = PostgresDatabase::UserStorage.new.username_validate(username)
      if response == true
        error_message
      else
        response_timeline = Timeline.new(@user_info).follow(username)
        follow_status(response_timeline, username)
      end
    end

    def my_timeline
      print_timeline
      tweets = Timeline.new(@user_info).show
      TimelineInterface.new.display_timeline(tweets)
    end

    def others_timeline
      TimelineInterface.new.username_validation_and_timeline
    end

    def tweet
      print "Compose New tweet : "
      tweet_message = input.to_s
      if User.new(@user_info, "").tweet(tweet_message) == :SUCCESS
        successfully_tweeted_message
      else
        tweet_length_error
      end
    end

    def re_tweet
      if others_timeline == :FAILED
        error_messege
      else
        re_tweet_by_tweet_id
      end
    end

    def re_tweet_by_tweet_id
      tweet_id = take_tweet_id
      response = User.new(@user_info, "").re_tweet(tweet_id)
      if response == :FAILED
        tweet_id_failure_message
      else
        successfully_tweeted_message
      end
    end

    def my_wall
      following_list = Timeline.new(@user_info).followings
      following_wall_display(following_list)
    end

    private
    def following_wall_display(following_list)
      puts "\t\t\t MY WALL "
      timeline_interface = TimelineInterface.new
      following_list.each do |following_username|
        timeline_interface.process(following_username)
      end
    end

    def tweet_id_failure_message
      puts "Tweet Id doesn't exist!!!  Please try again"
    end

    def take_tweet_id
      print "\n\tEnter Tweet Id for Retweet : "
      (input.to_i / security_factor)
    end

    def follow_status(response_timeline, username)
      if response_timeline == nil
        puts "\t You are already following #{username}"
      else
        puts "\t You are following #{username}"
      end
    end

    def error_messege
      puts "\tUser doesn't Exists"
    end

    def print_timeline
      puts "------------- * My Timeline * ----------------"
    end

    def successfully_tweeted_message
      puts "\tYour Tweet was posted!!!"
    end

    def tweet_length_error
      puts "Your tweet message size must be less 140 char."
    end
  end
end
