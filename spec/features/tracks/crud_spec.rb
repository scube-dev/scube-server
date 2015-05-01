feature 'Tracks CRUD' do
  include AcceptanceHelpers

  background { sign_in }

  scenario 'shows track' do
    track = FactoryGirl.create(:track, name: 'Mega song')

    visit track_path(track)

    expect(page).to have_content 'Mega song'
  end

  scenario 'creates track' do
    visit root_path

    click_link 'Add a track'
    fill_in 'Name', with: 'Mega song'
    attach_file 'File', File.expand_path('spec/fixtures/test.mp3')
    click_button 'Upload'

    expect(current_path).to eq track_path Track.first
    expect(page).to have_content 'Mega song'
  end
end
