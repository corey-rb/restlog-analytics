require 'spec_helper'

describe 'create_collection', :js => true do
  it 'should create a new collection and populate the message collection dropdown' do
    user1 = create(:user, email:'admin@goonsquad.com', password:'goonsquad')

    #create app for user
    app1 = create(:app, user:user1)

   #create messages for app
    mess1 = create(:message,
                    event:'{"apptype":"game","application":"Adventure Cave Conundrums","messageKey":"level6","gamedata":{"player":1,"level":{},"totalTime":"23.85.19","totalDeaths":"8","secrets":{"shrineWall":"true","brokenNecklace":"false","axeOfTheGods":"true"},"mostKilledBy":"fallingTree"}}',
                    event_data:{"apptype"=>"game","application"=>"Adventure Cave Conundrums","messageKey"=>"level6","gamedata"=>{"player"=>1,"level"=>{},"totalTime"=>"23.85.19","totalDeaths"=>"8","secrets"=>{"shrineWall"=>"true","brokenNecklace"=>"false","axeOfTheGods"=>"true"},"mostKilledBy"=>"fallingTree"}},
                    app:app1)
    mess2 = create(:message,
                    event:'{"apptype":"notgame","application":"Adventure Cave Conundrums","messageKey":"level6","gamedata":{"player":2,"level":{},"totalTime":"24.44.44","totalDeaths":"3","secrets":{"shrineWall":"false","brokenNecklace":"false","axeOfTheGods":"true"},"mostKilledBy":"fallingTree"}}',
                    event_data:{"apptype"=>"game","application"=>"Adventure Cave Conundrums","messageKey"=>"level6","gamedata"=>{"player"=>1,"level"=>{},"totalTime"=>"23.85.19","totalDeaths"=>"8","secrets"=>{"shrineWall"=>"true","brokenNecklace"=>"false","axeOfTheGods"=>"true"},"mostKilledBy"=>"fallingTree"}},
                    app:app1)

    mess_col1 = create(:message_collection, app:app1)

    visit '/'
    within(".login-container") do
      fill_in 'user_email', :with => 'admin@goonsquad.com'
      fill_in 'user_password', :with => 'goonsquad'
    end

    click_button 'Log In'

    page.execute_script("$('.AppNavigation').click()")#elements have to be visible so we show the app menu items
    page.execute_script("$('.AppList a')[0].click()")#elements have to be visible so we show the app menu items

    #make sure both messages created are shown
    expect(page).to have_selector('.table-data ul', count:2)

    #make sure the message colleciton selector has one to choose from and click button for new Message collection
    within("#view-app-detail .filter-options .message-collections") do
      expect(page).to have_selector('option', count:2)
      page.execute_script("$('.button-colored.new')[0].click()")
    end

    #fill in new Message collectin form with info
    within("#newCollection") do
      select 'apptype', :from => 'new-message-collection-message-root'
      fill_in 'new-message-collection-criteria-value', :with => 'notgame'
      fill_in 'new-message-collection-name', :with => 'Not Game Collection'
      page.execute_script("$('#newCollection')[0].save.click()")
    end

    #make sure the new collection is populated in the filter collection dropdown
    within("#view-app-detail .filter-options .message-collections") do
      expect(page).to have_selector('option', count:3)
    end

    #select newly created collection and search
    within("#view-app-detail .filter-options") do
      select 'Not Game Collection: apptype = notgame', :from => 'message-filter-message-collections'
      click_on "Search"
    end

    #this makes sure the filtering worked!
    expect(page).to have_selector('.table-data ul', count:1)

  end
end