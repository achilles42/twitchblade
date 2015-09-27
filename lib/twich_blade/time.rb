module TwichBlade
  class Time
    def initialize(given_time)
      @given_time = given_time
    end

    def show
      diff_in_sec = (Object::Time.new - @given_time).to_i.abs
      if diff_in_sec <= 59
        just_tweeted_meassage
      else
        @given_time.to_time.strftime("%d %b %Y")
      end
    end

    private
    def just_tweeted_meassage
      puts "Just Tweeted"
    end
  end
end
