module TwichBlade
  class TweetInterface < LoginInterface
    def display(response)
      puts "  1 tweet"
      puts "  2 logout"
      print "Enter your choise : "
      choise = input
      if input.to_i == 1
        print "tweet : "
        tweet_message = input.to_s
        User.new(response.field_values('username'), response.field_values('password')).tweet(tweet_message)
        puts "Tweet succesfully"
      else
        return "logout"
      end
    end
  end
end