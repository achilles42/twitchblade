module TwichBlade
  #Registration of new non-existing user
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
      @new_user = RegisteredUser.new(username, password)
    end

    def validate?
      !@new_user.exists?
    end

    def register
      if validate?
        @new_user.add
      else
        "sorry!!! user already exit"
      end
    end
  end
end
