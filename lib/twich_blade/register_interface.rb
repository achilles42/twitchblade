module TwichBlade
  #Guest/non-registred user can register
  class RegisterInterface < UserInterface
    def display
      display_header("SignUp")
      take_user_input
      if validate?
        @password = hash(@password)
        response = User.new(@username, @password).register
        display_response(response)
      else
        puts("ALERT !!! username length must be less than 15 and password must be between 6 to 14 char long")
      end
      display_index_page
    end

    def validate?
      @username != "" && @password != "" && @username.length < 15 && @password.length > 4 && @password.length < 15 ? true : false
    end

    private
    def display_response(response)
      if response == :FAILED
        puts "---------------------------------------------------------"
        p "User already exist with this UserName!!!  Please try again"
        puts "---------------------------------------------------------"
      else
        puts "---------------------------------------------------------"
        p "Congratulations signed up succesfully."
        puts "---------------------------------------------------------"
      end
    end
  end
end
