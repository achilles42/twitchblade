module TwichBlade
  #user should to login into the system
  class User
    def initialize(username, password)
      @username = username
      @password = password
    end

    def login
      :SUCCESS
    end
  end
end