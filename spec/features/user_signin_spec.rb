require 'spec_helper'

describe 'Sign In', :js => true do
  #create the user before testing
  before :each do
    create(:user, email:'admin@goonsquad.com', password:'goonsquad')
  end

  it 'should show the dashboard on successful login' do
    #make sure root redirects to home page and show login page content
    visit '/'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'

    #fill in login form and login
    within(".login-container") do
      fill_in 'user_email', :with => 'admin@goonsquad.com'
      fill_in 'user_password', :with => 'goonsquad'
      click_button 'Log In'
    end

    expect(page).to have_content 'Welcome to Restlog'
    expect(page).to have_content 'Dashboard'
    click_link 'Sign out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
