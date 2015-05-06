describe 'API sounds' do
  subject { response }

  before { api_sign_in }

  describe 'sound show' do
    let(:sound)           { create :sound }
    let(:request_method)  { :get }
    let(:request_path)    { api_sound_path(sound) }
    let(:request_show)    { send request_method, request_path }

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

  describe 'sounds create' do
    let(:file)    { attributes_for(:sound)[:file] }
    let(:upload)  { fixture_file_upload file.path, file.content_type }
    let(:sound)   { { file: upload } }

    before { post api_sounds_path, sound: sound }

    it { is_expected.to have_http_status 201 }

    it 'creates the sound' do
      get response.location
      expect(response.body).to eq File.read(file.path, mode: 'rb')
    end

    it 'returns the sound' do
      expect(json).to match(
        sound: {
          id:         an_instance_of(Fixnum),
          sha256:     /\A\h+\z/,
          mime_type: 'audio/mpeg'
        }
      )
    end

    context 'when sound is invalid' do
      let(:sound) { { file: nil } }

      it { is_expected.to have_http_status 422 }

      it 'returns errors' do
        expect(json :any).to include(
          sha256: [an_instance_of(String)]
        )
      end
    end
  end
end
