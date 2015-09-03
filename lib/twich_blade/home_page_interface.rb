module TwichBlade
  #user can see home page
  class HomePageInterface < LoginInterface
    def display(user_info)
      @user_info = user_info
      while true
        display_home_page
        choice = input
        if choice == "4"
          break
        else
          process(choice)
        end
      end
      display_index_page
    end

    def display_home_page
      print "  1 My Timeline\n  2 tweet\n  3 Other's  Timeline\n  4 logout\nEnter your choice : "
    end

    private
    def my_timeline
      puts "------------- * My Timeline * ----------------"
      tweets = Timeline.new(@user_info.field_values('username')[0].to_s, @dbname).show
      TimelineInterface.new(@dbname).display_timeline(tweets)
    end

    def others_timeline
      TimelineInterface.new(@dbname).username_validation_and_timeline
    end

    def tweet
      print "Compose New tweet : "
      tweet_message = input.to_s
      if tweet_message.length < 144
        User.new(@user_info.field_values('username')[0].to_s, @user_info.field_values('password')[0].to_s, @dbname).tweet(tweet_message, @user_info.field_values('id')[0].to_i)
        puts "\tYour Tweet was posted!"
      else
        puts "Your tweet message size must be less 144 char."
      end
    end

    def process(choice)
      if choice == "1"
        my_timeline
      elsif choice == "2"
        tweet
      elsif choice == "3"
        others_timeline
      else
        error_message
      end
    end
  end
end