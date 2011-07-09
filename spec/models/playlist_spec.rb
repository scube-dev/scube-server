require 'spec_helper'

describe Playlist do
  subject { playlist }
  let(:playlist) { Playlist.new :name => 'Electro' }

  context "with valid attributes" do
    it { should be_valid }
  end

  context "when name empty" do
    before do
      playlist.name = ''
    end

    it { should_not be_valid }
  end
end
