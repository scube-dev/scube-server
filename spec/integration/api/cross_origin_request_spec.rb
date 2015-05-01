describe 'API cross origin request' do
  include AcceptanceHelpers

  let(:user)    { create :user }
  let(:origin)  { 'http://origin.example/' }

  before do
    post sessions_path, session: {
      email:    user.email,
      password: user.password
    }
  end

  it 'responds to preflight request' do
    options api_playlists_path(format: :json), nil, 'Origin' => origin
    expect(response.headers).to include(
      'Access-Control-Allow-Origin'       => origin,
      'Access-Control-Allow-Credentials'  => 'true',
      'Access-Control-Allow-Methods'      => 'GET, POST, PUT, DELETE',
      'Access-Control-Allow-Headers'      =>
        'Content-Type, Content-Length, X-Requested-With'
    )
  end

  it 'responds to basic request' do
    get api_playlists_path(format: :json), nil, 'Origin' => origin
    expect(response.headers).to include(
      'Access-Control-Allow-Origin'       => origin,
      'Access-Control-Allow-Credentials'  => 'true',
      'Access-Control-Expose-Headers'     => 'Content-Length'
    )
  end

  it 'responds to request without origin' do
    get api_playlists_path format: :json
    expect(response.headers['Access-Control-Allow-Origin']).to eq ''
  end
end
