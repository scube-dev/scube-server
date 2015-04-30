describe 'tracks/new' do
  let(:track) { mock_model(Track).as_new_record.as_null_object }

  before { assign :track, track }

  it 'renders a form to create a track' do
    render
    expect(rendered)
      .to have_selector "form[method=post][action='#{tracks_path}']"
    expect(rendered).to have_selector 'input[type=submit]'
  end

  it 'renders a text field with a label for the playlists name' do
    allow(track).to receive(:name) { 'Mega song' }
    render
    expect(rendered)
      .to have_selector "input[type=text][name='track[name]'][value='Mega song']"
    expect(rendered).to have_selector('label[for=track_name]', text: 'Name')
  end

  it 'renders a file field with a label for the tracks file' do
    render
    expect(rendered).to have_selector("form[enctype='multipart/form-data']")
    expect(rendered).to have_selector("input[type=file][name='track[file]']")
    expect(rendered).to have_selector('label[for=track_file]', text: 'File')
  end
end
