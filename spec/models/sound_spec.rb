RSpec.describe Sound do
  subject(:sound) { build :sound }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :sha256 }
  it { is_expected.to validate_uniqueness_of :sha256 }
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
end
