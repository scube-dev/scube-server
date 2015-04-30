describe 'API cross origin request' do
  include UserIntegrationHelpers

  let(:user)    { FactoryGirl.create(:user) }
  let(:origin)  { 'http://origin.example/' }

  before do
    post sessions_path, session: {
      email:    user.email,
      password: user.password
    }
  end

  it 'responds to preflight request' do
    @integration_session.send(
      :process,
      :options,
      api_playlists_path(format: :json),
      nil,
      'Origin' => origin
    )

    expect(response.headers['Access-Control-Allow-Origin']).to eq origin
    expect(response.headers['Access-Control-Allow-Credentials']).to eq 'true'
    expect(response.headers['Access-Control-Allow-Methods'])
      .to eq 'GET, POST, PUT, DELETE'
    expect(response.headers['Access-Control-Allow-Headers'])
      .to eq 'Content-Type, Content-Length, X-Requested-With'
  end

  it 'responds to basic request' do
    # FIXME: replace with a more stable/generic action
    get api_playlists_path(format: :json), nil, 'Origin' => origin

    expect(response.headers['Access-Control-Allow-Origin']).to eq origin
    expect(response.headers['Access-Control-Allow-Credentials']).to eq 'true'
    expect(response.headers['Access-Control-Expose-Headers'])
      .to eq 'Content-Length'
  end

  it 'responds to request without origin' do
    # FIXME: replace with a more stable/generic action
    get api_playlists_path(format: :json)

    expect(response.headers['Access-Control-Allow-Origin']).to eq ''
  end
end
