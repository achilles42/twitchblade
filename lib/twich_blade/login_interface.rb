module TwichBlade
  class LoginInterface < UserInterface
    def initialize(dbname)
      @dbname = dbname
    end

    def display
      puts "--------------------------------"
      puts "   Welcome to SignIn page"
      puts "--------------------------------"
      print "Enter UserName : "
      username = input
      print "Enter Password : "
      password = input
      response = User.new(username, password, @dbname).login
      if response == :FAILED
        puts "------------------------------------------------"
        puts "UserName or Password is incorrect. please try again"
        puts "------------------------------------------------"
        display_index_page
      else
        puts "------------------------------------------------"
        puts "Welcome #{response.field_values('username')[0]} !!! you are succesfully signed in."
        puts "------------------------------------------------"
        TweetInterface.new(@dbname).display(response)
      end
    end
  end
end
