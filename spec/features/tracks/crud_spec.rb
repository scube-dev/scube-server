feature 'Tracks CRUD' do
  background { sign_in }

  scenario 'shows track' do
    track = create_track
    visit tracks_path

    click_link track[:name]

    expect(page).to have_content track[:name]
  end

  scenario 'edits track' do
    track = create_track
    visit tracks_path

    click_link track[:name]
    click_link 'Edit'
    fill_in 'Name', with: 'new track name'
    click_button 'Update Track'

    expect(current_path).to eq tracks_path
    expect(page).to have_content 'new track name'
  end
end
