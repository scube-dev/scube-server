describe Sound do
  subject(:sound) { build :sound }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :track }
  it { is_expected.to validate_presence_of :sha256 }
  it { is_expected.to validate_presence_of :mime_type }

  describe '#path' do
    it 'starts by the path specified in Rails.configuration.sound_path' do
      expect(sound.path).to match /\A#{Rails.configuration.sounds_path}/
    end

    it 'returns the sound file path based on the SHA256 digest' do
      expect(sound.path)
        .to eq "#{Rails.configuration.sounds_path}/#{sound.sha256}"
    end
  end

  describe '#file=' do
    let(:file) { attributes_for(:sound)[:file] }

    it 'saves the file SHA256 digest' do
      expect(sound.sha256).to eq Digest::SHA256.file(file.path).hexdigest
    end

    it 'copies the file to #path' do
      expect(File.read(sound.path)).to eq file.read
    end

    it 'saves the file MIME type' do
      expect(sound.mime_type).to eq 'audio/mpeg'
    end
  end
end
