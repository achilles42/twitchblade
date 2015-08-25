module TwichBlade
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
    end

    def validate
      true
    end
  end
end