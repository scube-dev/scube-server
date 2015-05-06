describe 'API application' do
  describe 'ping endpoint' do
    before { jget :ping }

    it 'responds with a pong' do
      expect(json).to eq(pong: true)
    end
  end

  describe 'authenticated ping endpoint' do
    let(:headers) { {} }
    subject       { response }

    before { jget :ping_auth, {}, headers }

    it 'requests authentication' do
      expect(response).to have_http_status 401
    end

    context 'when session is authenticated' do
      before { api_sign_in }

      it { is_expected.to have_http_status 200 }
    end

    context 'when requests has a valid authentication token' do
      let(:key)     { create :key }
      let(:headers) do {
        'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token
          .encode_credentials(key.token)
      } end

      it { is_expected.to have_http_status 200 }
    end
  end

  describe 'formats handling' do
    before { api_sign_in }

    it 'responds with a 406 when request format is not JSON' do
      get api_ping_path, format: :xml
      expect(response).to have_http_status 406
      expect(response.content_type).to eq :json
      expect(response.body).to be_empty
    end
  end

  describe 'not found' do
    before { api_sign_in }

    it 'responds with a 404 when route does not exist' do
      jget '/api/not_found'
      expect(response).to have_http_status 404
      expect(response.body).to be_empty
    end

    it 'responds with a 404 when a resource (AR) was not found' do
      jget api_playlist_path id: 1
      expect(response).to have_http_status 404
      expect(response.body).to be_empty
    end
  end
end
