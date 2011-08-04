Given /^I am not signed in$/ do

end

Given /^I am signed in$/ do
  user = Factory.create(:user)
  visit new_session_path
  fill_in('Email', :with => user.email)
  fill_in('Password', :with => user.password)
  click_button('Sign in')
end

Then /^I should be redirected to the sign in page$/ do
  current_path.should == new_session_path
end

Then /^I should be redirected to the home page$/ do
  current_path.should == root_path
end

When /^I submit valid credentials$/ do
  user = Factory.create(:user)
  fill_in('Email', :with => user.email)
  fill_in('Password', :with => user.password)
  click_button('Sign in')
end
