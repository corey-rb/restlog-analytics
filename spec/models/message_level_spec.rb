require 'spec_helper'

RSpec.describe MessageLevel, :type => :model do
  it 'should have a valid factory' do
    expect(create(:message_level)).to be_valid
  end

  describe 'by_code scope' do
    it 'should return the correct message level given codes' do
      create(:message_level)
      create(:message_level, code:'testcode1', name:'testname1')

      ml = MessageLevel.by_code(['testcode', 'testcode1'])

      #TODO:need to fix this
      #expect(ml.first.name).to eq('testname')
    end
  end
end
