describe 'API sounds' do
  before { api_sign_in }

  describe 'sound show' do
    let(:sound)         { create :sound }
    let(:request_show)  { get api_sound_path sound }
    subject             { response }

    before { request_show }

    it { is_expected.to have_http_status 200 }

    it 'has the sound mime type as content type' do
      expect(response.content_type).to eq sound.mime_type
    end

    it 'returns the sound file as the body' do
      expect(response.body).to eq File.read(sound.path, mode: 'rb')
    end
  end
end
