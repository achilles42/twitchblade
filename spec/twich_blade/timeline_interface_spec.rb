require 'spec_helper'

module TwichBlade
  describe 'user timeline' do
    it 'should able to display the timeline' do
      username = "foobar"
      dbname = "test_twichblade"
      obj = double()
      obj.stub(:show) { false }
      allow(Kernel).to receive(:gets).and_return(username)
      timeline_interface = TimelineInterface.new
      expect{ timeline_interface.username_validation_and_timeline }.to output(/\tSorry username doesn't exist/).to_stdout
    end
  end
end