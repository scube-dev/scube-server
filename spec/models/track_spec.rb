require 'spec_helper'

describe Track do
  subject     { track }
  let(:track) { FactoryGirl.build(:track) }
  let(:file)  { FactoryGirl.attributes_for(:track_with_sound)[:file] }

  it { should be_valid }
  it { should have_many :sounds }
  it { should validate_presence_of :name }

  context 'with a file' do
    before { track.file = file }

    it { should be_valid }

    it 'creates a sound for the track' do
      expect {
        track.save
      }.to change(track.sounds, :count).by(1)
    end
  end

  describe '#file=' do
    it 'builds a new related sound with the file' do
      sounds = double 'sounds association proxy'
      allow(track).to receive(:sounds) { sounds }
      expect(sounds).to receive(:build).with(file: file)
      track.file = file
    end
  end

  describe '#sound' do
    context 'with a sound' do
      before { track.sounds << FactoryGirl.create(:sound) }

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
      before { track.sounds << FactoryGirl.create(:sound) }

      it 'returns true' do
        expect(track.sound?).to be true
      end
    end
  end

  describe '.latest' do
    it 'returns latest tracks in descending creation date order' do
      track1 = FactoryGirl.create(:track, created_at: '2011-07-27 19:13:42')
      track2 = FactoryGirl.create(:track, created_at: '2011-07-27 19:58:57')
      expect(Track.latest).to eq [track2, track1]
    end
  end
end
