#require 'rails_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do

  subject(:user1) { create(:user) }

  describe "valid user" do
    it "is valid with the default factory" do
      expect(user1).to be_valid
    end
  end

  describe "invalid user" do
    it "is invalid with duplicate emails" do
      create(:user, email:'test@mail.com')
      expect(build(:user,email:'test@mail.com')).to_not be_valid
    end

    it "is invalid with nil email" do
      expect(build(:user, email: nil)).to_not be_valid
    end
  end

  describe "get user by key scope" do
    it "will return users who match the given key" do
      create(:user, account_key: :testkey1, email: 'test1@mail.com')
      create(:user, account_key: :testkey2, email:'test2@mail.com')

      user1 = User.by_key(:testkey1).first
      user2 = User.by_key(:testkey2).first

      expect(user1.email).to eq('test1@mail.com')
      expect(user2.email).to eq('test2@mail.com')
    end
  end
end
