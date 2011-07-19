Given /^a playlist named "([^"]*)"$/ do |name|
  Playlist.create!(:name => name)
end
