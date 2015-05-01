feature 'User sign up' do
  let(:user) { build :user }

  background do
    visit new_user_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
  end

  scenario 'creates the user' do
    expect {
      click_button 'Sign up'
    }.to change(User, :count).by(1)
  end

  scenario 'redirects to the home page' do
    click_button 'Sign up'

    expect(current_path).to eq root_path
  end
end
