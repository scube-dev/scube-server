module AcceptanceHelpers
  def sign_in
    user = FactoryGirl.create(:user)
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button('Sign in')
  end

  def api_sign_in
    user = FactoryGirl.create :user

    post_via_redirect api_sessions_path, format: :json, session: {
      email:    user.email,
      password: user.password
    }
  end

  def create_playlist
    playlist = attributes_for :playlist
    visit playlists_path
    click_link 'Create playlist'
    fill_in 'Name', with: playlist[:name]
    click_button 'Create'
    playlist
  end
end
