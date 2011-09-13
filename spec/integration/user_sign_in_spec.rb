require 'spec_helper'

feature 'User sign in' do
  scenario 'redirects to the home page when not signed in' do
    visit root_path

    current_path.should == new_session_path
  end

  scenario 'signs the user in' do
    user = Factory.create(:user)

    visit new_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'

    current_path.should == root_path
  end
end
