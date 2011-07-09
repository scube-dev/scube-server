require 'spec_helper'

describe 'playlists/index.html.haml' do
  before do
    assign :playlists, [
      double('Playlist', :name => 'Foo'),
      double('Playlist', :name => 'Bar')
    ]
  end

  it 'displays a list of playlists' do
    render
    rendered.should have_selector('ul>li', :count => 2)
    rendered.should have_selector('ul>li', :text => 'Foo')
    rendered.should have_selector('ul>li+li', :text => 'Bar')
  end

  it 'displays a link to create a new playlist' do
    render
    rendered.should have_selector('a', :text => 'Create playlist')
  end
end
