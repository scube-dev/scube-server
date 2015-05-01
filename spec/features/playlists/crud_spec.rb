feature 'Playlists CRUD' do
  include AcceptanceHelpers

  background { sign_in }

  scenario 'edits playlist' do
    playlist = create_playlist
    visit playlists_path

    click_link playlist[:name]
    fill_in 'Name', with: 'new playlist name'
    click_button 'Save'

    expect(current_path).to eq playlists_path
    expect(page).to have_content 'new playlist name'
  end
end
