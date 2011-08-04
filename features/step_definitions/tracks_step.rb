Given /^a track named "([^"]*)"$/ do |name|
  @track = Factory.create(:track, :name => name)
  file = File.new("#{Rails.root}/features/fixtures/test.mp3")
  @track.save_with_file(file, 'audio/mpeg')
end

Given /^the following tracks:$/ do |table|
  table.hashes.each do |h|
    Factory.create(:track, h)
  end
end

Then /^I should see an audio player$/ do
  page.should have_xpath '//audio'
end

Then /^it should provide an audio stream for "([^"]*)"$/ do |name|
  page.should have_xpath "//audio[@src='#{stream_track_path(@track)}']"
  visit find('audio')[:src]
end
