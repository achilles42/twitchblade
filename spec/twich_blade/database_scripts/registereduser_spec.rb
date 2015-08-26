require 'spec_helper'

module TwichBlade
  describe 'user validation' do
    it 'should check the availibility of username' do
      username = "foo"
      registered_user = RegisteredUser.new(username)
      expect(registered_user.exists?).to eq(false)
    end

    it 'should check the availibility of username' do
      username = "praveen"
      registered_user = RegisteredUser.new(username)
      expect(registered_user.exists?).to eq(true)
    end
  end
end
