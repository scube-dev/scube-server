feature 'Sounds CRUD' do
  background { sign_in }

  scenario 'shows sound' do
    track = create_track file: true
    visit tracks_path
    click_link track[:name]

    visit find('audio')[:src]

    expect(response_headers['Content-Type']).to eq 'audio/mpeg'
    expect(page.body).to eq_file_content track[:file].path
  end
end
