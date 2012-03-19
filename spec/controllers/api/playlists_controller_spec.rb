require 'spec_helper'

describe Api::PlaylistsController do
  include UserControllerHelpers

  before do
    sign_in
  end

  describe 'GET index' do
    before do
      playlist_1 = Factory.create(:playlist, :name => 'Playlist 1')
      playlist_2 = Factory.create(:playlist, :name => 'Playlist 2')
    end

    def do_get
      get :index, :format => :json
      JSON response.body
    end

    it 'lists all playlists' do
      do_get.should have(2).items
    end

    it 'lists playlists with their id' do
      do_get.each { |t| t.keys.should include 'id' }
    end

    it 'lists playlists with their name' do
      do_get.each { |t| t.keys.should include 'name' }
    end
  end
end
