require 'spec_helper'

describe 'playlists/index.html.haml' do
  before do
    assign :playlists, [
      mock_model('Playlist', :name => 'Electro')
    ]
  end

  it 'displays a list of playlists' do
    render
    rendered.should have_selector('ul>li', :text => 'Electro')
  end

  it 'displays a link to create a new playlist' do
    render
    rendered.should have_selector('a', :text => 'Create playlist')
  end

  it 'displays playlists as links' do
    render
    rendered.should have_selector('a', :text => 'Electro')
  end
end
