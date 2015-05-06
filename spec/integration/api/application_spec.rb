describe 'API application' do
  describe 'ping endpoint' do
    before { get api_ping_path, format: :json }

    it 'responds with a pong' do
      expect(json).to eq(pong: true)
    end
  end

  describe 'authenticated ping endpoint' do
    before { get api_ping_auth_path, format: :json }

    it 'requests authentication' do
      expect(response).to have_http_status 401
    end

    context 'when session is authenticated' do
      subject { response }

      before { api_sign_in }

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
      get '/api/not_found', format: :json
      expect(response).to have_http_status 404
      expect(response.body).to be_empty
    end

    it 'responds with a 404 when a resource (AR) was not found' do
      get api_playlist_path(id: 1), format: :json
      expect(response).to have_http_status 404
      expect(response.body).to be_empty
    end
  end
end
