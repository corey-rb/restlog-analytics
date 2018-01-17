require 'spec_helper'

RSpec.describe MessagesController, :type => :controller do

  describe 'index' do
    it 'should show the message index page if logged in  and pass correct id' do
      user = create(:user)
      sign_in(user)
      app = create(:app, user:user)
      app.messages.push(create(:message))

      get :index, :format => 'json', :app_id => app._id.to_s

      expect(response.status).to eq 200
      expect(response).to render_template 'messages/index'
      expect(assigns("messages").first.event).to eq "{\"testevent\":\"testdata\"}"
    end
  end

end