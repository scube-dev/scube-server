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
