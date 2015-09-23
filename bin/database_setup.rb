require 'pg'

conn = PG.connect( :dbname => 'staging_twichblade', :host => '10.1.1.33', :port => '5432', :user => 'twichblade', :password => 'twichblade')
conn.exec("create table users ( id serial primary key, username varchar(15) not null, password varchar(14) not null);")
conn.exec("create table followers ( user_id int references users(id), follower_id int references users(id), primary key (user_id, follower_id));")
conn.exec("create table tweets ( id serial primary key, user_id int references users(id) not null, tweet varchar(140) not null, data_and_time TIMESTAMP not null, retweet varchar(14));")
