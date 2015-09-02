module TwichBlade
  class Timeline
    def initialize(username, dbname)
      @username = username
      @conn = DBConnection.new(dbname).connection
    end

    def show
      user_id = @conn.exec("select id from users where username = $1",[@username]).field_values('id')[0].to_i
      @conn.exec("select (id, tweet, data_and_time) from tweets where user_id = $1",[user_id])
    end
  end
end