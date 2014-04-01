require 'spec_helper'

describe API::PlaylistsController do
  include UserControllerHelpers

  before do
    sign_in
  end

  describe 'GET index' do
    render_views

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

  describe 'POST create' do
    def do_create
      post :create,
        :format => :json,
        :playlist => Factory.attributes_for(:playlist)
    end

    it 'creates a new playlist for the current user' do
      expect {
        do_create
      }.to change(controller.current_user.playlists, :count).by(1)
    end

    it 'assigns the playlist' do
      do_create
      assigns[:playlist].should be_a Playlist
    end
  end
end
