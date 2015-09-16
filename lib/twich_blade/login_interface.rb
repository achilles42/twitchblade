module TwichBlade
  #user can login
  class LoginInterface < UserInterface
    def display
      display_header("SignIn")
      take_user_input
      logged_in = User.new(@username, @password).login
      binding.pry
      if logged_in == :FAILED
        unauthorized_user
      else
        authorized_user
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

    def unauthorized_user
      display_error_message
      display_index_page
    end

    def authorized_user
      response = User.new(@username, @password).get_user_info
      if response == nil
        puts "SORRY !!! something went wrong"
        display_index_page
      else
        welcome_message(response.field_values('username')[0])
        HomePageInterface.new.display(response)
      end
    end
  end
end
