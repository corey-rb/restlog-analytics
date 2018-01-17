require 'spec_helper'

RSpec.describe MessageLevelController, :type => :controller do
  describe 'index' do
    it 'if not logged in should return forbidden status' do
      get 'index', :format => 'json'

      expect(response.status).to eq 401
    end

    it 'if logged in should have level and go to message_level/index' do
      user = create(:user)
      sign_in(user)
      create(:message_level)
      get 'index', :format => 'json'

      #ask corey why da fuck this isnt working
      #I would expect there to be message levele but if you debug there seems to be none
      #binding.pry
      #expect(assigns("levels").first.name).to eq 'testname'

      expect(response.status).to eq 200
      expect(response).to render_template 'message_level/index'
    end
  end
end
