require 'spec_helper'

module TwichBlade
  describe 'user timeline' do
    it 'should able to validate the user and display the timeline' do
      username = "foobar"
      dbname = "test_twichblade"
      obj = double()
      obj.stub(:show) { false }
      allow(Kernel).to receive(:gets).and_return("twichblade")
      timeline_interface = TimelineInterface.new(dbname)
      expect{ timeline_interface.username_validation_and_timeline }.to output(/\tSorry username doesn't exist/).to_stdout
    end
  end
end