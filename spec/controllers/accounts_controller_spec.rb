 require 'spec_helper'

 RSpec.describe AccountsController, :type => :controller do
   it 'show should be found but forbidden for a un logged in user' do
     get :show, :format => 'json'
     expect(response.status).to eq 401
   end

   it 'should be successful for logged in user' do
     user = create(:user)
     sign_in(user)

     get :show, :format => 'json'
     expect(response.status).to eq 200
     expect(response).to render_template(:show)
   end
 end
