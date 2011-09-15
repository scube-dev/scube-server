require 'spec_helper'

describe Track do
  subject     { track }
  let(:track) { Factory.build(:track) }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when name empty' do
    before { track.name = '' }
    it { should_not be_valid }
  end

  describe '#file=' do
    it 'builds a new related sound with the file' do
      file = Factory.attributes_for(:track_with_sound)[:file]
      sounds = mock('sounds association proxy')
      track.stub(:sounds => sounds)
      sounds.should_receive(:build).with({:file => file})
      track.file = file
    end
  end

  describe '#sounds' do
    it 'responds to sound' do
      track.should respond_to(:sounds)
    end
  end

  describe '#sound' do
    context 'with a sound' do
      before do
        track.sounds << Factory.create(:sound)
      end

      it 'returns a sound' do
        track.sound.should be_a(Sound)
      end
    end
  end

  describe '#sound?' do
    context 'without a sound' do
      it 'returns false' do
        track.sound?.should be_false
      end
    end

    context 'with a sound' do
      before do
        track.sounds << Factory.create(:sound)
      end

      it 'returns true' do
        track.sound?.should be_true
      end
    end
  end

  describe '.latest' do
    it 'returns latest tracks in descending creation date order' do
      track1 = Factory.create(:track, :created_at => '2011-07-27 19:13:42')
      track2 = Factory.create(:track, :created_at => '2011-07-27 19:58:57')
      Track.latest.should == [track2, track1]
    end
  end
end
