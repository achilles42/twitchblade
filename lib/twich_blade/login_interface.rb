module TwichBlade
  class LoginInterface < UserInterface
    def process
      puts "--------------------------------"
      puts "   Welcome to SignIn page"
      puts "--------------------------------"
      print "Enter UserName : "
      username = input
      print "Enter Password : "
      password = input
      response = User.new(username, password).login
      if response == :FAILED
        puts "------------------------------------------------"
        puts "UserName or Password is incorrect. please try again"
        puts "------------------------------------------------"
        process
      else
        puts "------------------------------------------------"
        puts "Welcome #{response.field_values('username')} !!! you are succesfully signed in."
        puts "------------------------------------------------"
      end
    end
  end
end
