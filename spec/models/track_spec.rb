require 'spec_helper'

describe Track do
  subject { track }
  let(:track) { Factory.build(:track) }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when name empty' do
    before { track.name = '' }
    it { should_not be_valid }
  end

  context 'when mime_type empty' do
    before { track.mime_type = '' }
    it { should_not be_valid }
  end

  context 'when sha256 empty' do
    before { track.sha256 = '' }
    it { should_not be_valid }
  end

  describe '#filepath' do
    it 'returns the path to the track file' do
      track.filepath.should == "#{Rails.root}/data/tracks/#{track.sha256}"
    end
  end

  describe '#save_with_file' do
    let(:file) { File.new("#{Rails.root}/spec/fixtures/test.mp3") }

    it 'calls save' do
      Track.any_instance.should_receive(:save!)
      track.save_with_file(file, 'audio/ogg')
    end

    it 'saves the file content' do
      track.save_with_file(file, 'audio/ogg')
      File.read(track.filepath).should == File.read(file.path)
    end

    it 'saves the file SHA256 digest' do
      track.save_with_file(file, 'audio/ogg')
      track.sha256.should == Digest::SHA256.file(file.path).hexdigest
    end

    it 'saves the file mime type' do
      track.save_with_file(file, 'audio/mpeg')
      track.mime_type.should == 'audio/mpeg'
    end

    after do
      `rm -f #{Rails.root}/data/tracks/*`
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
