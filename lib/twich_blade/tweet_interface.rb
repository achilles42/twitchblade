module TwichBlade
  class TweetInterface < LoginInterface
    def display(user_info)
      puts "  1 Timeline"
      puts "  2 tweet"
      puts "  3 logout"
      print "Enter your choise : "
      choise = input
      if choise.to_i == 1
        puts "------------- * My Timeline * ----------------"
        tweets = Timeline.new(user_info.field_values('username')[0].to_s, @dbname).show
        display_timeline(tweets)
        display(user_info)
      elsif choise.to_i == 2
        print "tweet : "
        tweet_message = input.to_s
        User.new(user_info.field_values('username'), user_info.field_values('password'), @dbname).tweet(tweet_message, user_info)
        puts "Tweet succesfully"
        display(user_info)
      else
        puts "you are succesfully logout"
        display_index_page
      end
    end

    def display_timeline(tweets)
      puts "tweet_id | -----------------tweet-------------------  |  date and time"
      for tweet in 0..tweets.ntuples - 1
      puts "#{tweets.field_values('id')[tweet]} | #{tweets.field_values('tweet')[tweet]}| #{tweets.field_values('date_and_time')[tweet]}"
      puts "\n----------------------------------------------"
      end
    end
  end
end
