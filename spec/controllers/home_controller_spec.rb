require 'spec_helper'

describe HomeController do
  describe 'GET index' do
    it 'assigns all playlists as @playlists' do
      playlist = Factory.create(:playlist)
      get :index
      assigns[:playlists].should == [playlist]
    end
  end
end
