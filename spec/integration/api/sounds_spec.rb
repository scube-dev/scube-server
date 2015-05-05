describe 'API sounds' do
  before { api_sign_in }

  describe 'sound show' do
    let(:sound)           { create :sound }
    let(:request_method)  { :get }
    let(:request_path)    { api_sound_path(sound) }
    let(:request_show)    { send request_method, request_path }
    subject               { response }

    before { request_show }

    it { is_expected.to have_http_status 200 }

    it 'has the sound mime type as content type' do
      expect(response.content_type).to eq sound.mime_type
    end

    it 'returns the sound file as the body' do
      expect(response.body).to eq File.read(sound.path, mode: 'rb')
    end

    context 'when method is HEAD' do
      let(:request_method) { :head }

      it { is_expected.to have_http_status 200 }

      it 'returns an empty body' do
        expect(response.body).to be_empty
      end
    end

    context 'when sound is requested by SHA256 digest' do
      let(:request_path) { api_sound_path id: sound.sha256 }

      it { is_expected.to have_http_status 200 }
    end
  end
end
