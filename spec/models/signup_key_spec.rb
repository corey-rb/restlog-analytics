require 'spec_helper'


RSpec.describe SignupKey, :type => :model do

  describe 'valid signup key factory' do
    it 'returns a valid signup key instance' do
      expect(build(:signup_key)).to be_valid
    end
  end

  describe 'invalid keys' do
    it 'will be invalid if keys are reused' do
      expect(create(:signup_key)).to be_valid
      expect(build(:signup_key)).to_not be_valid
      expect(build(:signup_key, key: 'testkey')).to be_valid
    end

    it 'is invalid without a signup key key' do
      expect(build(:signup_key, key:nil)).to_not be_valid
    end
  end

  describe 'key redemption' do
    it 'should deactivate the singleuse signup key only' do
      single_use_key = build(:signup_key)
      multi_use_key = build(:signup_key, key_type:2)

      expect(single_use_key.isvalid || multi_use_key.isvalid).to eq(false)#both need to be false
      expect(single_use_key.active && multi_use_key.active).to eq(true)#both need to be true

      #use send to access protected functions
      single_use_key.send(:redeem_key)
      multi_use_key.send(:redeem_key)

      expect(single_use_key.isvalid || multi_use_key.isvalid).to eq(false)#both need to be false
      expect(single_use_key.active).to eq(false)
      expect(multi_use_key.active).to eq(true)
    end
  end

  describe 'make valid and validate_key?' do
    it 'makes isvalid value true and tests the value' do
      suk = build(:signup_key)
      expect(suk.validate_key?).to eq(false)

      suk.make_valid!

      expect(suk.validate_key?).to eq(true)
    end
  end
  # this is using syntax from the mongoid-rspec gem
  #it { is_expected.to validate_presence_of(:key) }

end
