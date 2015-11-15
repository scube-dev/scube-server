RSpec.describe Track do
  subject(:track) { build :track }

  it { is_expected.to be_valid }

  it { is_expected.to have_many :sounds }

  it { is_expected.to validate_presence_of :name }

  describe '#sound' do
    context 'with a sound' do
      before { track.sounds << create(:sound) }

      it 'returns a sound' do
        expect(track.sound).to be_a Sound
      end
    end
  end

  describe '#sound?' do
    context 'without any sound' do
      it 'returns false' do
        expect(track.sound?).to be false
      end
    end

    context 'with a sound' do
      before { track.sounds << create(:sound) }

      it 'returns true' do
        expect(track.sound?).to be true
      end
    end
  end
end
