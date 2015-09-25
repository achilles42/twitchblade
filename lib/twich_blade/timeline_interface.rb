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
      process(username)
    end

    def process(username)
       timeline = Timeline.new(username).show
      if timeline == false
        error_message
      else
        display_timeline(timeline)
      end
    end

    def display_timeline(tweets)
      if tweets.ntuples != 0
        display_tweets(tweets)
      end
    end

    def display_tweets(tweets)
      for tweet in 0..tweets.ntuples - 1
        day = tweets.field_values('date_and_time')[tweet].to_time.strftime("%d")
        month = tweets.field_values('date_and_time')[tweet].to_time.strftime("%b")
        year = tweets.field_values('date_and_time')[tweet].to_time.strftime("%Y")
        puts "Tweet Id : #{tweets.field_values('id')[tweet].to_i * security_factor}"
        puts "Tweet :  #{tweets.field_values('tweet')[tweet]} "
        puts "Posted By: @#{tweets.field_values('retweet')[tweet]} | #{day} #{month} #{year} "
        puts "\n--------------------------------------------------------------------"
      end
    end

    private
    def error_message
      puts "\tSorry username doesn't exist"
      :FAILED
    end
  end
end
