require 'spec_helper'

module TwichBlade
  describe 'user interface' do
    context 'input' do
      it 'should able to take input from user' do
        allow(Kernel).to receive(:gets).and_return("twichblade")
        twich_blade_cli = TwichBladeCLI.new
        expect(twich_blade_cli.input).to eq("twichblade")
      end
    end

    context 'Error' do
      it 'should generate error message when user entered the wrong input' do
        twich_blade_cli = TwichBladeCLI.new
        expect{ twich_blade_cli.error_message }.to output(/\tPlease Enter the correct choice : /).to_stdout
      end
    end
  end
end
