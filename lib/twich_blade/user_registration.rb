module TwichBlade
  #Registration of new non-existing user
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
      @new_user = RegisteredUser.new(username)
    end

    def validate?
      !@new_user.exists?
    end
  end
end
