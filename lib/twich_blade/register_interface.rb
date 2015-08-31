module TwichBlade
  class RegisterInterface < UserInterface
    def initialize(dbname)
      @dbname = dbname
    end

    def display
      puts "-------------------------------"
      puts "   Welcome to SignUp Page"
      puts "-------------------------------"
      print "Enter UserName : "
      username = input
      print "Enter Password : "
      password = input
      response = UserRegistration.new(username, password, @dbname).register
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
  end
end
