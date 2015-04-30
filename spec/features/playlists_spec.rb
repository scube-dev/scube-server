feature 'Playlists' do
  include UserIntegrationHelpers

  background { sign_in }

  scenario 'lists playlists' do
    FactoryGirl.create(:playlist, name: 'Electro')
    FactoryGirl.create(:playlist, name: 'Reggae')

    visit playlists_path

    expect(page.body).to match /Electro.+Reggae/m
  end

  scenario 'creates playlist' do
    visit playlists_path

    click_link 'Create playlist'
    fill_in 'Name', with: 'Electro'
    click_button 'Create'

    expect(current_path).to eq playlists_path
    expect(page).to have_content 'Electro'
  end

  scenario 'edits playlist' do
    FactoryGirl.create(:playlist, name: 'Electro')
    visit playlists_path

    click_link 'Electro'
    fill_in 'Name', with: 'Rock'
    click_button 'Save'

    expect(current_path).to eq playlists_path
    expect(page).to have_content 'Rock'
  end
end
