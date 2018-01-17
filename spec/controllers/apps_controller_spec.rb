require 'spec_helper'

RSpec.describe AppsController, :type => :controller do
  @user
  before :each do
    @user = create(:user)
    sign_in(@user)
  end
  describe 'index' do
    it 'if logged in it will go to the apps/index page' do
      get :index, :format => 'json'

      @user.apps.push create(:app, user:@user)

      get :index, :format => 'json'

      expect(response.status).to be 200
      expect(response).to render_template 'apps/index'
      expect(assigns("apps").first.name).to eq 'goonsquad'
    end
  end

  describe 'edit' do
    it 'should update the app attributes and go to apps/show' do
      app1 = create(:app, user:@user)
      app2 = create(:app, user:@user)

      put 'edit', :format => 'json', :id => app2._id, :name => 'somename', :hex_color_label => '#fff', :monitor=>true
      app2.reload

      expect(response.status).to eq 200
      expect(app2.name).to eq 'somename'
      expect(response).to render_template 'apps/show'
    end
  end

  describe 'create' do
    it 'should make a new app from params and go to show page' do
      @user.name = "testname"
      @user.save
      expect(App.count).to eq 0

      post 'create', :format => 'json', :name => 'appname', :hex => '#FFF', :monitor => false

      expect(App.count).to eq 1
      expect(App.first.name).to eq 'appname'         #make sure the name in the post is on the app that was created
      expect(App.first.user.name).to eq 'testname'    #make sure the user created above is on the app we created
      expect(response).to render_template 'apps/show'
      expect(response.status).to eq 200
    end
  end

  describe 'show' do
    it 'should return the correct app based on the id passed in' do
      app = create(:app, user:@user)
      get 'show', :format => 'json', :id => app._id

      expect(response.status).to eq 200
      expect(assigns("app").name).to eq 'goonsquad'#make sure the app from the factory is returned
      expect(response).to render_template 'apps/show'

    end
  end
end
