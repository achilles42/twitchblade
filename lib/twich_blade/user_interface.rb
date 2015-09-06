module TwichBlade
  #take input from user and call methods
  class UserInterface
    def input
      Kernel.gets.chomp
    end

    def run
      display_index_page
      @input_string = input
      while true
        interface = nil
        if @input_string == "1"
          interface = RegisterInterface.new
        elsif @input_string == "2"
          interface = LoginInterface.new
        elsif @input_string == "3"
          interface = TimelineInterface.new
        elsif @input_string == "4"
          break
        else
          error_message
          @input_string = input
          next
        end
        interface.display
        @input_string = input
      end
    end

    def display_index_page
      print "-------------------------------\n\tWelcome to TwichBlade\t\n-------------------------------\n\t1   SignUp\n\t2   SignIn\n\t3   Timeline\n\t4   Exit\nEnter your Choice  :"
    end

    def display_header(page)
      puts "--------------------------------\n   Welcome to #{page} page\n--------------------------------"
    end

    def take_user_input
      print "Enter UserName : "
      @username = input
      print "Enter Password : "
      @password = input
    end

    def error_message
      puts "\tPlease Enter the correct choice : "
    end
  end
end
