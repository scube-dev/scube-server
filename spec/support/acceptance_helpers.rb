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
      jpost api_sessions_path, session: {
        email:    o.email,
        password: o.password
      }
    end
    @api_key_token = json[:session][:token]
  end

  def create_key
    attributes_for :key do |o|
      visit keys_path
      click_link 'New key'
      fill_in 'Name', with: o[:name]
      click_button 'Create'
    end
  end

  def create_playlist
    attributes_for :playlist do |o|
      visit playlists_path
      click_link 'New playlist'
      fill_in 'Name', with: o[:name]
      click_button 'Create'
    end
  end

  def create_track file: false
    attributes_for file ? :track_with_sound : :track do |o|
      visit tracks_path
      click_link 'New track'
      fill_in 'Name', with: o[:name]
      attach_file 'File', o[:file].path if file
      click_button 'Create'
    end
  end

  %w[get post put delete options].each do |verb|
    define_method :"j#{verb}" do |path, params = nil, headers = {}|
      path = path.is_a?(Symbol) ? send(:"api_#{path}_path") : path
      params = JSON.generate(params) if params
      send verb.to_sym, path, params, json_request_headers.merge(headers)
    end
  end

  def json status = :success
    expect(response).to have_http_status status unless status == :any
    JSON.parse(response.body, symbolize_names: true)
  end

private

  def json_request_headers
    {
      'Accept'        => 'application/json',
      'Content-Type'  => 'application/json'
    }.tap do |o|
      o.merge!(
        'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token
          .encode_credentials(@api_key_token)
      ) if @api_key_token
    end
  end
end
