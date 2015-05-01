feature 'Playlists CRUD' do
  include AcceptanceHelpers

  background { sign_in }

  scenario 'edits playlist' do
    playlist = create_playlist
    visit playlists_path

    click_link playlist[:name]
    fill_in 'Name', with: 'Rock'
    click_button 'Save'

    expect(current_path).to eq playlists_path
    expect(page).to have_content 'Rock'
  end
end
