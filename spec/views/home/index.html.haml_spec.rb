require 'spec_helper'

describe 'home/index.html.haml' do
  before do
    assign :playlists, [
      mock_model('Playlist', :name => 'Electro')
    ]
  end

  it 'displays a list of playlists' do
    render
    rendered.should have_selector('ul>li', :text => 'Electro')
  end

  it 'displays a link to add a track' do
    render
    rendered.should have_selector('a', :text => 'Add a track')
  end
end
