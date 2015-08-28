module TwichBlade
  #take input from user and call methods
  class UserInterface
    def initialize
    end

    def input
      Kernel.gets.chomp
    end

    def run
      display_index_page
      @input_string = input
      while @input_string != "logout"
        foo = nil
        if @input_string.to_i == 1
          interface = RegisterInterface.new
          interface.display
        elsif @input_string.to_i == 2
          interface = LoginInterface.new
          interface.display
        else
          print "Please Enter the correct choice : "
        end
        @input_string = input
      end
    end

    def display_index_page
      puts "-------------------------------"
      puts "     Welcome to TwichBlade     "
      puts "-------------------------------"
      puts "    1   SignUp"
      puts "    2   SignIn"
      print " Enter your Choice  :  "
    end
  end
end
