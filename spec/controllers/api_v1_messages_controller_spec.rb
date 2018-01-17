require 'spec_helper'

RSpec.describe Api::V1::MessagesController, :type => :controller do

  it 'should create a new message for the app' do
    user = create(:user, account_key:'testacckey')
    sign_in(user)
    app = create(:app, user:user, monitor:true)
    app.message_levels.push(create(:message_level, level:2, app:app))

    post 'create',
          :format => 'json',
          :restlog => {:api_key => 'testacckey', :app_key => 'testtoken'},
          :message => {:application_name => 'test app name',
                       :event => %Q'{ "employees" : [' +
                          '{ "firstName":"John" , "lastName":"Doe" },' +
                          '{ "firstName":"Anna" , "lastName":"Smith" },' +
                          '{ "firstName":"Peter" , "lastName":"Jones" } ]}',
                       :level => 2}

    expect(response.status).to eq(200)
    expect(JSON.parse( assigns["message"].event)["employees"][0]["firstName"]).to eq("John")
    expect(response).to render_template(:create)
  end
end