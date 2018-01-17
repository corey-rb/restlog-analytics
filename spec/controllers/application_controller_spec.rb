require 'spec_helper'

RSpec.describe ApplicationController, :type => :controller do
  it 'should do redirect to login if not logged in' do
    get :index

    expect(response).to redirect_to '/users/sign_in'
    expect(response.status).to eq 302
  end

  it 'should do redirect to angular if logged in' do
    user = create(:user)
    sign_in(user)

    get :index

    expect(response).to render_template 'layouts/angular'
    expect(response.status).to eq 200
  end
end