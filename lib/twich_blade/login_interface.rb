module TwichBlade
  #user can login
  class LoginInterface < UserInterface
    def display
      display_header("SignIn")
      take_user_input
      response = User.new(@username, @password, @dbname).login
      if response == :FAILED
        display_error_message
        display_index_page
      else
        welcome_message(response.field_values('username')[0])
        HomePageInterface.new(@dbname).display(response)
      end
    end

    private
    def display_error_message
      puts "---------------------------------------------------"
      puts "UserName or Password is incorrect. please try again"
      puts "---------------------------------------------------"
    end

    def welcome_message(user_name)
      puts "-------------------------------------------------------"
      puts "Welcome #{user_name} !!! you are successfully signed in."
      puts "-------------------------------------------------------"
    end
  end
end
