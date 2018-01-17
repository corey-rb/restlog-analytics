require 'spec_helper'

describe 'App behaviour', :js => true do
  before :each do
    #create a user to login as and then login so we can test app behavior
    create(:user, email:'admin@goonsquad.com', password:'goonsquad')

    visit '/'
    within(".login-container") do
      fill_in 'user_email', :with => 'admin@goonsquad.com'
      fill_in 'user_password', :with => 'goonsquad'
    end
    click_button 'Log In'
  end

  #these were separated but creating user and logging in before every test seemed unnecessary, we could change it though
  it 'should have no apps to start and creating them populates side' do
    within(".nav") do
      expect(page).to have_no_selector('li.AppList')#initially the list will not exist
      page.execute_script("$('.AppNavigation').click()")#elements have to be visible so we show the app menu items
      expect(page).to have_content '+ All ( 0 )'

     click_link 'CreateApp'
    end

    #fill form for creating app and save it
    within('form#NewAppForm') do
      fill_in 'name', :with => 'test app'
      find("option[value='true']").click
      choose 'NewAppPurple'
      click_button 'Save App'
    end

    #make sure creating the app propagated in the side app
    within(".nav") do
      expect(page).to have_content '+ All ( 1 )'
      expect(page).to have_selector('li.AppList')
    end
  end
end
