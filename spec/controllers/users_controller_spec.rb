require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
  @user
  before :each do
    @user = create(:user)
    sign_in(@user)
  end

  describe 'profile' do
    it 'should be success and go to the users/show' do
      get :profile, :format => 'json'

      expect(response.status).to eq 200
      expect(response).to render_template 'users/show'
    end
  end

  describe 'update' do
    it 'should update the users billing information and go to the show template' do
      get :update,:format => 'json', :billing_data => create(:billing_information, first_name:'test2').as_json
      @user.reload

      expect(@user.billing_information.first_name).to eq 'test2'
      expect(response.status).to eq 200
      expect(response).to render_template 'users/show'
    end
  end

  describe 'gen_key' do
    it 'should generate a new acount key and render the show page' do
      expect(@user.account_key).to eq nil
      get :gen_key, :format => 'json'
      @user.reload

      expect(@user.account_key).to_not eq nil
    end
  end
end
