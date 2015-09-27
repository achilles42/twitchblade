require 'spec_helper'

module TwichBlade
  describe 'time' do
    it 'should able to give date of action' do
      time = Object::Time.new
      time_object = Time.new(time)
      expect(time_object.show).to eq(time.to_time.strftime("%d %b %Y"))
    end
  end
end
