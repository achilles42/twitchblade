module TwichBlade
  #user can see home page
  class HomePageInterface < UserInterface
    def display(user_info)
      @user_info = user_info
      while true
        display_home_page
        choice = input
        if choice == "7"
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

    private
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
      if response.ntuples != 1
        puts "\tUser name doesn't Exists"
      else
        response1 = Timeline.new(@user_info.field_values('username')[0].to_s).follow(username)
        if response1 == nil
          puts "\t You are already following #{username}"
        else
          puts "\t You are following #{username}"
        end
      end
    end

    def my_timeline
      puts "------------- * My Timeline * ----------------"
      tweets = Timeline.new(@user_info.field_values('username')[0].to_s).show
      TimelineInterface.new.display_timeline(tweets)
    end

    def others_timeline
      TimelineInterface.new.username_validation_and_timeline
    end

    def tweet
      print "Compose New tweet : "
      tweet_message = input.to_s
      if tweet_message.length < 144
        User.new(@user_info.field_values('username')[0].to_s, @user_info.field_values('password')[0].to_s).tweet(tweet_message)
        puts "\tYour Tweet was posted!"
      else
        puts "Your tweet message size must be less 144 char."
      end
    end

    def re_tweet
      if others_timeline == :FAILED
        puts "User Doesn't Exists!!!"
        return
      else
        print "\n\tEnter Tweet Id for Retweet : "
        tweet_id = input.to_i
        response = User.new(@user_info.field_values('username')[0].to_s, @user_info.field_values('password')[0].to_s).re_tweet(tweet_id)
        if response == :FAILED
          puts "Tweet Id doesn't exist!!!  Please try again"
        else
          puts "Retweet Successfully"
        end
      end
    end

    def my_wall
      following_list = Timeline.new(@user_info.field_values('username')[0].to_s).my_wall
      puts "\t\t\t MY WALL "
      timeline_interface = TimelineInterface.new
      following_list.each do |following_username|
        timeline_interface.process(following_username)
      end
    end
  end
end
