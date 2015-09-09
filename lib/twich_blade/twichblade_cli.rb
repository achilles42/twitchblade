module TwichBlade
  #take input from user and deligate the responsibility
  class TwichBladeCLI
    def input
      Kernel.gets.chomp
    end

    def run
      UserInterface.new.display_index_page
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
  end
end
