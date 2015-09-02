module TwichBlade
  #take input from user and call methods
  class UserInterface
    def initialize(dbname)
      @dbname = dbname
    end

    def input
      Kernel.gets.chomp
    end

    def run
      display_index_page
      @input_string = input
      while @input_string != "3"
        interface = nil
        if @input_string == "1"
          interface = RegisterInterface.new(@dbname)
        elsif @input_string == "2"
          interface = LoginInterface.new(@dbname)
        else
          print "Please Enter the correct choice : "
          @input_string = input
          next
        end
        interface.display
        @input_string = input
      end
    end

    def display_index_page
      print "-------------------------------\n\tWelcome to TwichBlade\t\n-------------------------------\n\t1   SignUp\n\t2   SignIn\n\t3   Exit\nEnter your Choice  :"
    end
  end
end
