require 'spec_helper'

describe 'playlists/edit.html.haml' do
  let(:playlist) do
    mock_model('Playlist').as_new_record.as_null_object
  end

  before do
    assign :playlist, playlist
  end

  it 'renders a form to edit a playlist' do
    render
    rendered.should \
      have_selector("form[method=post][action='#{playlists_path}']")
    rendered.should have_selector('input[type=submit]')
  end

  it 'renders a text field with a label for the playlists name' do
    playlist.stub(:name => 'Electro')
    render
    rendered.should \
      have_selector("input[type=text][name='playlist[name]'][value=Electro]")
    rendered.should \
      have_selector("label[for=playlist_name]", :text => 'Name')
  end
end
