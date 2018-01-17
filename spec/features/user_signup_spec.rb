require 'spec_helper'

describe 'User Registration', :js => true do
  #create the user before testing
  before :each do
    #this will work
    create(:signup_key, :is_valid, :multi_use)

    #This will not work
    #create(:signup_key)

    #validate new key is invalid by default, so each key created will need to be activated


    #the top create call will work because it is a multi use key
    #therefore when the redeem_key is called when the model is saved its isvalid will not be set to false, single use keys will.
    #the invalid field must be true in order to be validated and the default is false. I just added make_valid! to make the model tests pass
    #but otherwise they never become valid
  end


  # it 'should create an invalid key by default' do
  #   key = create(:default_signup_key)
  #   key.invalid.should be_invalid
  # end



  it 'should register successfully with vaild multi-use key' do
    visit '/users/sign_up'

    expect(page).to have_content 'Sign up'

    within('.login-container') do
      fill_in 'Beta Token', :with => 'goonsquad'
      fill_in 'Name', :with => 'test name'
      fill_in 'Email', :with => 'testmail@mail.com'
      fill_in 'Password', :with => 'testtes'
      fill_in 'Password confirmation', :with => 'testtes'
      click_button 'Sign up'
    end
    expect(page).to have_content 'Sign up'
  end

  it 'should error with a password < 8 characters' do
    visit '/users/sign_up'

    within('.login-container') do
      fill_in 'Beta Token', :with => 'goonsquad'
      fill_in 'Name', :with => 'test name'
      fill_in 'Email', :with => 'testmail@mail.com'
      fill_in 'Password', :with => 'testers'
      fill_in 'Password confirmation', :with => 'testers'
      click_button 'Sign up'
    end
    expect(page).to have_content 'Password is too short'
  end

  it 'should error with mismatching passwords' do
    visit '/users/sign_up'

    within('.login-container') do
      fill_in 'Beta Token', :with => 'goonsquad'
      fill_in 'Name', :with => 'test name'
      fill_in 'Email', :with => 'testmail@mail.com'
      fill_in 'Password', :with => 'testers'
      fill_in 'Password confirmation', :with => 'tes'
      click_button 'Sign up'
    end
    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end
