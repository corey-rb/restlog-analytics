require 'spec_helper'

RSpec.describe MessageCollection, type: :model do
  it 'has a valid factory' do
    expect(create(:message_collection)).to be_valid
  end

  describe 'by user scope' do
    it 'should return the correct collection based on user' do
      user1 = create(:user, name:'collection test1')
      user2 = create(:user, name:'collection test2')

      mc1 = create(:message_collection, user:user1)
      mc2 = create(:message_collection, user:user2)

      test_mc = MessageCollection.by_user(user2)

      expect(test_mc.first.user.name).to eq('collection test2')
    end
  end

  describe 'by_app scope' do
    it 'should return the correct message collection based on the app given' do
      app1 = create(:app)
      app2 = create(:app, name:'test app name')

      mc1 = create(:message_collection, app:app1)
      mc2 = create(:message_collection, app:app2)

      test_mc = MessageCollection.by_app(app2)

      expect(test_mc.first.app.name).to eq('test app name')
    end
  end
end
