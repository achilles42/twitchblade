module TwichBlade
  class Time
    def initialize(given_time)
      @given_time = given_time
    end

    def show
      time_difference_in_sec = (Object::Time.new - @given_time).to_i.abs
      if time_difference_in_sec <= 59
        just_tweeted_meassage
      elsif time_difference_in_sec > 60 && time_difference_in_sec <= 3600
        minutes = time_difference_in_sec/60
        minutes_message(minutes)
      else
        @given_time.to_time.strftime("%d %b %Y")
      end
    end

    private
    def just_tweeted_meassage
      puts 'Just Tweeted'
    end

    def minutes_message(minutes)
      puts "#{minutes} minutes ago"
    end
  end
end
