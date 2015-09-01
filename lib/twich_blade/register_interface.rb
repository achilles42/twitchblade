module TwichBlade
  class RegisterInterface < UserInterface
    def display(dbname)
      puts "-------------------------------"
      puts "   Welcome to SignUp Page"
      puts "-------------------------------"
      display_user_input
      while 1
        if validate?
          response = UserRegistration.new(@username, @password, dbname).register
          break
        else
          puts("ALERT !!! username length must be less than 15 and password must be between 6 to 14 char long")
          display_user_input(dbname)
        end
      end
      if response == :FAILED
        puts "------------------------------------------------"
        p "User already exist with this UserName. \n Please try again"
        puts "------------------------------------------------"
        display_index_page
      else
        puts "------------------------------------------------"
        p "Congrats !!! signed up succesfully."
        puts "------------------------------------------------"
        display_index_page
      end
    end

    def display_user_input
      print "Enter UserName : "
      @username = input
      print "Enter Password : "
      @password = input
    end

    def validate?
      if @username != ""
        true
      else
        false
      end
    end
  end
end
