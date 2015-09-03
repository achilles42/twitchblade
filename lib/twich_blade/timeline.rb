module TwichBlade
  #show the timeline of registred users
  class Timeline
    def initialize(username, dbname)
      @username = username
      @conn = DBConnection.new(dbname).connection
    end

    def show
      user_id = get_user_id
      user_id != 0 ? @conn.exec("select id, tweet, date_and_time from tweets where user_id = $1",[user_id]) : false
    end

    def get_user_id
      @conn.exec("select id from users where username = $1",[@username]).field_values('id')[0].to_i
    end
  end
end