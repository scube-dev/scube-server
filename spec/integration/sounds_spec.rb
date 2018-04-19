RSpec.describe 'Sounds' do
  subject { response }

  before { sign_in }

  describe 'sound show' do
    let(:sound)           { create_sound }
    let(:request_method)  { :get }
    let(:request_path)    { sound_path sound }
    let(:request_show)    { send "j#{request_method}", request_path }

    before { request_show }

    it { is_expected.to have_http_status 200 }

    it 'has the sound mime type as content type' do
      expect(response.content_type).to eq sound[:mime_type]
    end

    it 'returns the sound file as the body' do
      expect(response.body)
        .to eq_file_content attributes_for(:sound, :with_file_upload)[:file].path
    end

    context 'when method is HEAD' do
      let(:request_method) { :head }

      it { is_expected.to have_http_status 200 }

      it 'returns an empty body' do
        expect(response.body).to be_empty
      end
    end

    context 'when sound is requested by SHA256 digest' do
      let(:request_path) { sound_path id: sound[:sha256] }

      it { is_expected.to have_http_status 200 }
    end
  end

  describe 'sounds create' do
    let(:sound) { create_sound }

    before { sound }

    it { is_expected.to have_http_status 201 }

    it 'creates the sound' do
      sound_file = attributes_for(:sound, :with_file_upload).fetch :file
      jget response.location
      expect(response.body).to eq_file_content sound_file.path
    end

    it 'returns the sound' do
      expect(json).to match sound: {
        id: Integer,
        sha256: /\A\h+\z/,
        mime_type: 'audio/mpeg'
      }
    end

    context 'when sound is invalid' do
      let(:sound) { create_sound file: nil }

      it { is_expected.to have_http_status 422 }

      it 'returns errors' do
        expect(json :any).to include sha256: [String]
      end
    end
  end
end
