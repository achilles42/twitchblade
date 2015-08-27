module TwichBlade
  class UserInterface
    def initialize
    end

    def input
      @input_string = Kernel.gets.chomp
    end

    def run
      display_index_page
      input
      while @input_string != "exit"
        delegate_to_controller
        input
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
