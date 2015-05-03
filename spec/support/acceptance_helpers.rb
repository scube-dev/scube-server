module AcceptanceHelpers
  def options path, options = nil, headers = nil
    @integration_session.send :process, :options, path, options, headers
  end

  def sign_in
    create :user do |o|
      visit new_session_path
      fill_in 'Email', with: o.email
      fill_in 'Password', with: o.password
      click_button 'Sign in'
    end
  end

  def api_sign_in
    create :user do |o|
      post api_sessions_path, format: :json, session: {
        email:    o.email,
        password: o.password
      }
    end
  end

  def create_playlist
    attributes_for :playlist do |o|
      visit playlists_path
      click_link 'Create playlist'
      fill_in 'Name', with: o[:name]
      click_button 'Create'
    end
  end

  def create_track file: false
    attributes_for file ? :track_with_sound : :track do |o|
      visit tracks_path
      click_link 'Create track'
      fill_in 'Name', with: o[:name]
      attach_file 'File', o[:file].path if file
      click_button 'Upload'
    end
  end

  def json status = 200
    expect(response.status).to be status
    JSON.parse(response.body, symbolize_names: true)
  end
end
