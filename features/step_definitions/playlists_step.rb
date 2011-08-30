Given /^a playlist named "([^"]*)"$/ do |name|
  Factory.create(:playlist, :name => name)
end

Then /^I should see "([^"]*)" and "([^"]*)" in a list$/ do |pl1, pl2|
  page.should have_selector('ul>li:first-child', :text => pl1)
  page.should have_selector('ul>li:first-child+li', :text => pl2)
end

Then /^I should see "([^"]*)" in the list$/ do |playlist_name|
  page.should have_selector('ul>li', :text => playlist_name)
end
