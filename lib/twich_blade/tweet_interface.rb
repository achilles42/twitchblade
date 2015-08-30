module TwichBlade
  class TweetInterface < LoginInterface
    def display(response)
      puts "  1 tweet"
      puts "  2 logout"
      print "Enter your choise : "
      choise = input
      if choise.to_i == 1
        print "tweet : "
        tweet_message = input.to_s
        User.new(response.field_values('username'), response.field_values('password')).tweet(tweet_message, response)
        puts "Tweet succesfully"
        display(response)
      else
        puts "you are succesfully logout"
        return exit
      end
    end
  end
end
