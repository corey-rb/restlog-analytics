require 'spec_helper'

RSpec.describe App, :type => :model do

  it 'has a valid factory' do
    expect(create(:app)).to be_valid
  end

  it 'is invalid without user' do
    expect(build(:app, user:nil)).to_not be_valid
  end

  it 'is invalid without app_token' do
    expect(build(:app, app_token:nil)).to_not be_valid
  end

  it 'is invalid without name' do
    expect(build(:app, name:nil)).to_not be_valid
  end

  describe 'app by user scope' do
    it 'should return the app matching the given user' do
      user1 = create(:user)
      user2 = create(:user)

      create(:app, user:user1, name: 'user1')
      create(:app, user:user2, name: 'user2')

      app3 = App.user_apps(user1).first()
      app4 = App.user_apps(user2).first()

      expect(app3.name).to eq('user1')
      expect(app4.name).to eq('user2')
    end
  end

  describe 'app_messages scope' do
    it 'should return the correct app based on the app_id' do
      app1 = create(:app, name: 'app1')
      app2 = create(:app, name: 'app2')

      app3 = App.app_messages(app1.id).first()
      app4 = App.app_messages(app2.id).first()

      expect(app3.name).to eq('app1')
      expect(app4.name).to eq('app2')
    end
  end

  describe 'by_token scope' do
    it 'should return the correct app based on the app_token' do
      create(:app, name:'app1', app_token:'testtoken')
      create(:app, name:'app2', app_token:'testtoken2')

      app1 = App.by_token('testtoken').first()
      app2 = App.by_token('testtoken2').first()

      expect(app1.name).to eq('app1')
      expect(app2.name).to eq('app2')
    end
  end


end
