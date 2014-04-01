require 'spec_helper'

describe 'playlists/new' do
  let(:playlist) do
    mock_model(Playlist).as_new_record.as_null_object
  end

  before do
    assign :playlist, playlist
  end

  it 'renders a form to create a playlist' do
    render
    expect(rendered)
      .to have_selector "form[method=post][action='#{playlists_path}']"
    expect(rendered)
      .to have_selector 'input[type=submit]'
  end

  it 'renders a text field with a label for the playlists name' do
    allow(playlist).to receive(:name) { 'Electro' }
    render
    expect(rendered)
      .to have_selector "input[type=text][name='playlist[name]'][value=Electro]"
    expect(rendered)
      .to have_selector 'label[for=playlist_name]', text: 'Name'
  end
end
