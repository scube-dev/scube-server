require 'spec_helper'

describe API::PlaylistsController do
  include UserControllerHelpers

  before { sign_in }

  describe 'GET index' do
    render_views

    before do
      playlist_1 = FactoryGirl.create(:playlist, name: 'Playlist 1')
      playlist_2 = FactoryGirl.create(:playlist, name: 'Playlist 2')
    end

    def do_get
      get :index, format: :json
      JSON response.body
    end

    it 'lists all playlists' do
      expect(do_get).to have(2).items
    end

    it 'lists playlists with their id' do
      do_get.each { |t| expect(t.keys).to include 'id' }
    end

    it 'lists playlists with their name' do
      do_get.each { |t| expect(t.keys).to include 'name' }
    end
  end

  describe 'POST create' do
    def do_create
      post :create,
        format: :json,
        playlist: FactoryGirl.attributes_for(:playlist)
    end

    it 'creates a new playlist for the current user' do
      expect {
        do_create
      }.to change(controller.current_user.playlists, :count).by(1)
    end

    it 'assigns the playlist' do
      do_create
      expect(assigns[:playlist]).to be_a Playlist
    end
  end
end
