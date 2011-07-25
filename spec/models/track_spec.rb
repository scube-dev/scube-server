require 'spec_helper'

describe Track do
  subject { track }
  let(:track) { FactoryGirl.build(:track) }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when name empty' do
    before do
      track.name = ''
    end

    it { should_not be_valid }
  end

  describe '#uploaded_file=' do
    let(:track) { Track.new :name => 'Mega song' }

    it 'saves an uploaded file' do
      filepath = "#{Rails.root}/spec/fixtures/test.mp3"
      file = mock(Rack::Test::UploadedFile)
      file.stub(
        :tempfile     => File.new(filepath),
        :content_type => 'audio/mpeg'
      )
      track.uploaded_file = file
      track.save
      File.read("#{Rails.root}/data/tracks/#{track.id.to_s}").should == File.read(filepath)
    end

    after do
      `rm -rf #{Rails.root}/data/tracks/*`
    end
  end
end
