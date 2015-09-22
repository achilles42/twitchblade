module TwichBlade
  #provide interface to the user
  class UserInterface
    def security_factor
      9999
    end

    def input
      Kernel.gets.chomp
    end

    def display_index_page
      print "-------------------------------\n\tWelcome to TwichBlade\t\n-------------------------------\n\t1   SignUp\n\t2   SignIn\n\t3   Timeline\n\t4   Exit\nEnter your Choice  :"
    end

    def display_header(page)
      puts "--------------------------------\n   Welcome to #{page} page\n--------------------------------"
    end

    def take_user_input
      print "Enter UserName : "
      @username = input
      print "Enter Password : "
      @password = input
    end

    def error_message
      puts "\tPlease Enter the correct choice : "
    end

    def connection_error
      puts "Something went wrong!!! please try again"
    end
  end
end
