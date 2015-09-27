require 'spec_helper'

module TwichBlade
  describe 'Time' do
    context 'show' do
      it 'should be able to give just tweeted message' do
        time  = Object::Time.new + 35
        time_object = Time.new(time)
        expect { time_object.show }.to output(/Just Tweeted/).to_stdout
      end
    end
  end
end
