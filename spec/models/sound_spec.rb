require 'spec_helper'

describe Sound do
  subject     { sound }
  let(:sound) { Factory.build(:sound) }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when sha256 empty' do
    before { sound.sha256 = '' }
    it { should_not be_valid }
  end

  context 'when mime_type empty' do
    before { sound.mime_type = '' }
    it { should_not be_valid }
  end

  describe '#path' do
    it 'returns the sound file path based on the SHA256 digest' do
      sound.path.should == "#{Rails.root}/data/sounds/#{sound.sha256}"
    end
  end

  describe '#file=' do
    let (:file) { Factory.attributes_for(:sound)[:file] }

    it 'saves the file SHA256 digest' do
      sound.sha256.should == Digest::SHA256.file(file.path).hexdigest
    end

    it 'copies the file to #path' do
      File.read(sound.path).should == file.read
    end

    it 'saves the file MIME type' do
      sound.mime_type.should == 'audio/mpeg'
    end
  end
end
