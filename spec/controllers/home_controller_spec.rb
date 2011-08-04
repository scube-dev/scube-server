require 'spec_helper'

describe HomeController do
  before do
    controller.current_user = Factory.create(:user)
  end

  describe 'GET index' do
    it 'assigns all playlists as @playlists' do
      playlist = Factory.create(:playlist)
      get :index
      assigns[:playlists].should == [playlist]
    end

    it 'assigns latest tracks as @tracks' do
      track1 = Factory.create(:track, :created_at => '2011-07-27 19:13:42')
      track2 = Factory.create(:track, :created_at => '2011-07-27 19:58:57')
      get :index
      assigns[:tracks].should == Track.latest
    end
  end
end
