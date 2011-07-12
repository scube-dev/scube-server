Given /^Foo and Bar playlists$/ do
  @foo = Playlist.create!(:name => 'Foo')
  @bar = Playlist.create!(:name => 'Bar')
end

Given /^a playlist named Electro$/ do
  Playlist.create!(:name => 'Electro')
end
