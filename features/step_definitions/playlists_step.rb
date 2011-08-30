Given /^a playlist named "([^"]*)"$/ do |name|
  Factory.create(:playlist, :name => name)
end

Then /^I should see "([^"]*)" and "([^"]*)" in a list$/ do |pl1, pl2|
  Then "I should see \"#{pl1}\" within \"ul>li:first-child\""
  Then "I should see \"#{pl2}\" within \"ul>li:first-child+li\""
end

Then /^I should see "([^"]*)" in the list$/ do |playlist_name|
  Then "I should see \"#{playlist_name}\" within \"ul>li\""
end
