module TwichBlade
  class Time
    def initialize(given_time)
      @given_time = given_time
    end

    def show
      @given_time.to_time.strftime("%d %b %Y")
    end
  end
end
