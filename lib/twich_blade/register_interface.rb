module TwichBlade
  class RegisterInterface < UserInterface
    def display
      puts "-------------------------------"
      puts "   Welcome to SignUp Page"
      puts "-------------------------------"
      print "Enter UserName : "
      username = input
      print "Enter Password : "
      password = input
      response = UserRegistration.new(username, password).register
      if response == :FAILED
        puts "------------------------------------------------"
        p "User already exist with this UserName. \n Please try again"
        puts "------------------------------------------------"
        display
      else
        puts "------------------------------------------------"
        p "Congrats !!! signed up succesfully."
        puts "------------------------------------------------"
        display_index_page
      end
    end
  end
end
