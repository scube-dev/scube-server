feature 'Keys CRUD' do
  TOKEN_PATTERN = /\b[\w\d]{24}\b/

  let(:key) { create_key }

  background do
    sign_in
    key
  end

  scenario 'lists keys' do
    visit keys_path

    expect(page).to have_content key[:name]
    expect(page.body).not_to match TOKEN_PATTERN
  end

  scenario 'shows key' do
    visit keys_path

    click_link key[:name]

    expect(page).to have_content key[:name]
    expect(page.body).to match TOKEN_PATTERN
  end

  scenario 'edits key' do
    visit keys_path

    click_link 'Edit'
    fill_in 'Name', with: 'new key name'
    click_button 'Update'

    expect(current_path).to eq keys_path
    expect(page).to have_content 'new key name'
  end

  scenario 'destroys key' do
    visit keys_path

    click_link 'Destroy'

    expect(current_path).to eq keys_path
    expect(page).not_to have_content key[:name]
  end
end
