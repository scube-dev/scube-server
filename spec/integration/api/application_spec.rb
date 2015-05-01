describe 'API application' do
  include AcceptanceHelpers

  before { api_sign_in }

  describe 'ping endpoint' do
    before { get api_ping_path, format: json }

    it 'responds with a pong' do
      expect(json).to eq({ pong: 'ok' })
    end
  end
end
