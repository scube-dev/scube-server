describe 'API cross origin request' do
  let(:origin) { 'http://origin.example/' }

  before { api_sign_in }

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
