module AcceptanceHelpers
  def options path, options = nil, headers = nil
    @integration_session.send :process, :options, path, options, headers
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

  %i[head get post put delete options].each do |verb|
    define_method :"do_#{verb}" do |path, params = nil, headers = {}|
      send verb, _request_path(path), params, _request_headers.merge(headers)
    end

    define_method :"j#{verb}" do |path, params = nil, headers = {}|
      params = JSON.generate(params) if params
      send :"do_#{verb}", path, params, _request_headers_json.merge(headers)
    end
  end

  def json status = :success
    expect(response).to have_http_status status unless status == :any
    JSON.parse(response.body, symbolize_names: true)
  end

  def create_sound **options
    attributes_for :sound_with_file_upload, options do |attrs|
      do_post api_sounds_path, sound: attrs
    end
    json(:any)[:sound]
  end

  def create_track **options
    attributes_for :track, options do |attrs|
      do_post api_tracks_path, track: attrs
    end
    json(:any)[:track]
  end

private

  def _request_path path
    path.is_a?(Symbol) ? send(:"api_#{path}_path") : path
  end

  def _request_headers
    {}.tap do |o|
      o.merge!(
        'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token
          .encode_credentials(@api_key_token)
      ) if @api_key_token
    end
  end

  def _request_headers_json
    {
      'Accept'        => 'application/json',
      'Content-Type'  => 'application/json'
    }
  end
end
