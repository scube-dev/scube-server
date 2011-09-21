require 'spec_helper'

describe Sound do
  subject     { sound }
  let(:sound) { Factory.build(:sound) }

  it { should be_valid }
  it { should belong_to :track }
  it { should validate_presence_of :sha256 }
  it { should validate_presence_of :mime_type }

  describe '#path' do
    it 'starts by the path specified in Rails.configuration.sound_path' do
      sound.path.should match(/\A#{Rails.configuration.sounds_path}/)
    end

    it 'returns the sound file path based on the SHA256 digest' do
      sound.path.should == "#{Rails.configuration.sounds_path}/#{sound.sha256}"
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
