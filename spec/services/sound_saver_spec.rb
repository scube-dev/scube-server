RSpec.describe SoundSaver do
  include ActionDispatch::TestProcess

  let(:file)    { 'spec/fixtures/test.mp3'.freeze }
  let(:upload)  { fixture_file_upload file, 'audio/mpeg' }
  let(:sound)   { Sound.new }
  let(:service) { described_class.new sound, upload }

  describe '#call' do
    it 'sets the SHA256 message digest of the file on the sound' do
      service.call
      expect(sound.sha256).to eq Digest::SHA256.file(file).hexdigest
    end

    it 'moves the given file' do
      service.call
      expect(File.read(sound.path)).to eq File.read(file)
    end

    it 'sets the MIME type given with the file upload' do
      service.call
      expect(sound.mime_type).to eq 'audio/mpeg'
    end

    it 'saves the sound' do
      service.call
      expect(sound).to be_persisted
    end

    context 'when no file upload is given' do
      let(:upload) { nil }

      it 'adds an error about the missing file' do
        service.call
        expect(sound.errors).to have_key :sha256
      end

      it 'does not save the sound' do
        service.call
        expect(sound).not_to be_persisted
      end
    end
  end
end
