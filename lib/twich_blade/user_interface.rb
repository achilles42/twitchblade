module TwichBlade
  #take input from user and call methods
  class UserInterface
    def initialize
      @delegation = Delegation.new
    end

    def input
      Kernel.gets.chomp
    end

    def run
      display_index_page
      @input_string = input
      while @input_string != "logout"
        if @input_string.to_i == 1
          puts "Welcome to SignUp page"
          puts "Enter UserName"
          @username = input
          puts "Enter Password"
          @password = input
          response = UserRegistration.new(@username, @password).register
          if response == :FAILED
            puts "User already exist with this UserName."
          else
            puts "Congrats !!! signed up succesfully"
          end

        elsif @input_string.to_i == 2
          puts "Welcome to SignIn page"
          puts "Enter UserName"
          @username = input
          puts "Enter Password"
          @password = input
          response = User.new(@username, @password).login
          if response == :SUCCESS

          else

          end
        else

        end
        @input_string = input
      end
    end

    private
    def display_index_page
      puts "Welcome to TwichBlade"
      puts "  1 SignUp"
      puts "  2 SignIn"
      puts "Enter your Choice : "
    end

  end
end
