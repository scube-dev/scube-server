require 'spec_helper'

describe 'tracks/new.html.haml' do
  let(:track) do
    mock_model('Track').as_new_record.as_null_object
  end

  before do
    assign :track, track
  end

  it 'renders a form to create a track' do
    render
    rendered.should have_selector("form[method=post][action='#{tracks_path}']")
    rendered.should have_selector('input[type=submit]')
  end

  it 'renders a text field with a label for the playlists name' do
    track.stub(:name => 'Mega song')
    render
    rendered.should \
      have_selector("input[type=text][name='track[name]'][value='Mega song']")
    rendered.should \
      have_selector('label[for=track_name]', :text => 'Name')
  end

  it 'renders a file field with a label for the tracks file' do
    render
    rendered.should have_selector("form[enctype='multipart/form-data']")
    rendered.should \
      have_selector("input[type=file][name='track[file]']")
    rendered.should \
      have_selector('label[for=track_file]', :text => 'File')
  end
end
