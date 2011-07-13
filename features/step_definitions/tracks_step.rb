Given /^a track named "([^"]*)"$/ do |name|
  @track = Track.create!(:name => name)
end

Then /^I should see an audio player$/ do
  page.should have_xpath '//audio'
end

Then /^it should provide an audio stream for "([^"]*)"$/ do |name|
  page.should have_xpath "//audio[@src='#{stream_track_path(@track)}']"
end
