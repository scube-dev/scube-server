require 'spec_helper'

describe Playlist do
  subject { playlist }
  let(:playlist)  { Factory.build(:playlist) }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when name empty' do
    before do
      playlist.name = ''
    end

    it { should_not be_valid }
  end

  context 'without user_id' do
    before do
      playlist.user = nil
    end

    it { should_not be_valid }
  end

  describe '#user' do
    it 'returns the user who created the playlist' do
      user = Factory.create(:user)
      playlist = user.playlists.build(Factory.attributes_for(:playlist))
      playlist.user.should == user
    end
  end
end
