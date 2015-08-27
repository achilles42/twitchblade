require 'spec_helper'

module TwichBlade
  describe 'user registration' do
    before(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo1', 'bar1')")
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo2', 'bar2')")
      conn.exec("insert into users(id, username, password) values(DEFAULT, 'foo3', 'bar3')")
    end

    after(:each) do
      conn = PG.connect(:dbname => 'test_twichblade')
      conn.exec("delete from users")
    end

    context 'validation' do
      it 'should able to check the availbility of username' do
        username = 'foo1'
        password = 'bar1'
        new_user = UserRegistration.new(username, password)
        expect(new_user.validate?).to eq(false)
      end

      it 'should able to check the availbility of username' do
        username = 'foo4'
        password = 'bar4'
        new_user = UserRegistration.new(username, password)
        expect(new_user.validate?).to eq(true)
      end
    end
  end
end
