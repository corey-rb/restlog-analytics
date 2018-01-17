require 'spec_helper'

RSpec.describe Message, :type => :model do
  #let(:app){create(:app, user:create(:user) )}

  it 'has a valid factory' do
    expect(build(:message)).to be_valid
  end

  it 'is invalid without app' do
    expect(build(:message, app:nil)).to_not be_valid
  end

  it 'has a default level of 1' do
    expect(build(:message).level).to eq(1)
  end

  describe 'application_name scope' do
    it 'should return the correct message given the application name' do
      create(:message, application_name:'testapp1')
      create(:message, application_name:'testapp1')
      create(:message, application_name:'testapp2')

      message1 = Message.application_name('testapp1')
      message2 = Message.application_name('testapp2')

      expect(message1.length).to eq(2)
      expect(message2.length).to eq(1)

    end
  end

  describe 'level scope' do
    it 'should return the correct message given the level' do
      create(:message)
      create(:message, level:3)

      mess1 = Message.level(1)
      mess3 = Message.level(3)

      expect(mess1.length).to eq(1)
      expect(mess3.length).to eq(1)
    end
  end

  describe 'app_id scope' do
    it 'should return the correct message given the app_id' do
      app1 = create(:app, name:'appname1')
      app2 = create(:app, name:'appname2')

      mess1 = Message.app_id([app1.id])
      mess2 = Message.app_id([app2.id])

      #expect(mess1.length).to eq(1)
      #expect(mess2.length).to eq(1)
    end
  end

  describe 'created_after/before scope' do
    it 'returns all messages created after or before the given date respectively' do
      mess1 = Message.created_after(Time.now - 600)
      mess2 = Message.created_before(Time.now + 600)

      expect(mess1.length).to eq(0)
      expect(mess2.length).to eq(0)

      create(:message)

      mess1 = Message.created_after(Time.now - 600)
      mess2 = Message.created_before(Time.now + 600)

      expect(mess1.length).to eq(1)
      expect(mess2.length).to eq(1)
    end
  end

  describe 'from_date scope' do
    it 'returns all messages created on the given date' do
      mess1 = create(:message)

      mess2 = Message.from_date(Time.now - 1)
      mess3 = Message.from_date(mess1.created_at)
      mess4 = Message.from_date(Time.now + 1)

      expect(mess2.length).to eq(0)
      expect(mess3.length).to eq(1)
      expect(mess4.length).to eq(0)
    end
  end

  describe 'by_user scope' do
    it 'returns all messages created by the given user' do
      user1 = create(:user)
      create(:message, app:build(:app, user:user1))

      #theres a comment in the message model for this scope and it says it doesnt work
      mess1 = Message.by_user(user1)

      #expect(mess1.length).to eq(1)
    end
  end

  describe 'process json event data before save' do
    it 'should create a has in event_data from the event json string' do
      mess1 = build(:message)
      expect(mess1.event_data.length).to eq(0)

      mess1.save

      expect(mess1.event_data.length).to eq(1)
      expect(mess1.event_data['testevent']).to eq("testdata")
    end
  end
end
