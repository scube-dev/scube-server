describe 'API cross origin request' do
  let(:origin) { 'http://origin.example/' }

  before { api_sign_in }

  it 'responds to preflight request' do
    joptions :ping, {}, 'Origin' => origin
    expect(response.headers).to include(
      'Access-Control-Allow-Origin'       => origin,
      'Access-Control-Allow-Credentials'  => 'true',
      'Access-Control-Allow-Methods'      => 'GET, POST, PUT, DELETE',
      'Access-Control-Allow-Headers'      =>
        'Authorization, Content-Type, Content-Length, X-Requested-With'
    )
  end

  it 'responds to basic request' do
    jget :ping, {}, 'Origin' => origin
    expect(response.headers).to include(
      'Access-Control-Allow-Origin'       => origin,
      'Access-Control-Allow-Credentials'  => 'true',
      'Access-Control-Expose-Headers'     => 'Content-Length'
    )
  end

  it 'responds to request without origin' do
    jget :ping
    expect(response.headers['Access-Control-Allow-Origin']).to eq ''
  end
end
