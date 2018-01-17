require 'spec_helper'

RSpec.describe MessageCollectionsController, type: :controller do
  describe 'index' do
    it 'will go to index page with the collections by user when no app id is given' do
      user1 = create(:user)
      create(:message_collection, user:user1, name:'test collection')
      sign_in(user1)

      get :index, :format => 'json'

      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(assigns["collections"].first.name).to eq('test collection')
    end

    it 'will go to the index page with the collections belonging to the current users apps that match the given app id' do
      user1 = create(:user)
      sign_in(user1)
      app1 = create(:app, user:user1, name:'test app name1')
      app2 = create(:app, user:user1, name:'test app name2')
      app2.message_collections.push(create(:message_collection))

      get :index, :format => 'json',
                  :app_id => app2._id.to_s

      expect(response.status).to eq(200)
      expect(assigns["collections"].first.name).to eq("test name")
      expect(response).to render_template(:index)
    end
  end
end
