describe 'API application' do
  include AcceptanceHelpers

  before { api_sign_in }

  describe 'ping endpoint' do
    before { get api_ping_path, format: :json }

    it 'responds with a pong' do
      expect(json).to eq(pong: 'ok')
    end
  end

  describe 'formats handling' do
    it 'responds with a 406 when request format is not JSON' do
      get api_ping_path, format: :xml
      expect(response.status).to be 406
      expect(response.body).to be_empty
    end
  end

  describe 'not found' do
    it 'responds with a 404 when route does not exist' do
      get '/api/not_found', format: :json
      expect(response).to be_not_found
      expect(response.body).to be_empty
    end
  end
end
