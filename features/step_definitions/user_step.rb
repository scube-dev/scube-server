Given /^a user with "([^"]*)" email address exists$/ do |email|
  Factory.create(:user, :email => email)
end

When /^I register with "([^"]*)" email address$/ do |email|
  visit new_user_path
  user = Factory.build(:user)
  fill_in('Email', :with => email)
  fill_in('Password', :with => user.password)
  fill_in('Password confirmation', :with => user.password)
  click_button('Sign up')
end
