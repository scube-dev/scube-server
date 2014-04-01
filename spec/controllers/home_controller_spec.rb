require 'spec_helper'

describe HomeController do
  include UserControllerHelpers

  before do
    sign_in
  end

  describe 'GET index' do
    it 'assigns all playlists as @playlists' do
      playlist = FactoryGirl.create(:playlist)
      get :index
      expect(assigns[:playlists]).to eq [playlist]
    end

    it 'assigns latest tracks as @tracks' do
      track1 = FactoryGirl.create(:track, created_at: '2011-07-27 19:13:42')
      track2 = FactoryGirl.create(:track, created_at: '2011-07-27 19:58:57')
      get :index
      expect(assigns[:tracks]).to eq Track.latest
    end
  end
end
