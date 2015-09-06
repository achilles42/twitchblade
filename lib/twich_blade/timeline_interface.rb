module TwichBlade
  #we can view registred users timeline
  class TimelineInterface < UserInterface
    def display
      display_header("View Timeline")
      username_validation_and_timeline
      display_index_page
    end

    def username_validation_and_timeline
      print "Enter Username :"
      username = input
      timeline = Timeline.new(username).show
      if timeline == false
        puts "\tSorry username doesn't exist"
      else
        display_timeline(timeline)
      end
    end

    def display_timeline(tweets)
      if tweets.ntuples != 0
        display_tweets(tweets)
      else
        puts "\n\t\tSorry!!! No tweets found"
      end
    end

    def display_tweets(tweets)
      for tweet in 0..tweets.ntuples - 1
        puts "Tweet Id : #{tweets.field_values('id')[tweet]} \t\tDate & Time  : #{tweets.field_values('date_and_time')[tweet]} "
        puts "Tweet :  #{tweets.field_values('tweet')[tweet]}"
        puts "Retweet Post : #{tweets.field_values('retweet')[tweet]}"
        puts "\n--------------------------------------------------------------------"
      end
    end
  end
end
