require 'spec_helper'

describe Track do
  subject { track }
  let(:track) { Track.new :name => 'Mega song' }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when name empty' do
    before do
      track.name = ''
    end

    it { should_not be_valid }
  end
end
