require 'spec_helper'

describe PlaylistsController do
  include UserControllerHelpers

  before { sign_in }

  describe 'GET index' do
    it 'assigns all playlists as @playlists' do
      playlist = FactoryGirl.create(:playlist)
      get :index
      expect(assigns[:playlists]).to eq [playlist]
    end
  end

  describe 'GET new' do
    it 'assigns a new playlist as @playlist' do
      get :new
      expect(assigns[:playlist]).to be_a_new Playlist
    end
  end

  describe 'GET edit' do
    it 'assigns the requested playlist as @playlist' do
      playlist = FactoryGirl.create(:playlist)
      get :edit, id: playlist.id.to_s
      expect(assigns[:playlist]).to eq playlist
    end
  end

  describe 'POST create' do
    def do_create
      post :create, playlist: FactoryGirl.attributes_for(:playlist)
    end

    context 'whith valid params' do
      it 'creates a new playlist for the current user' do
        expect {
          do_create
        }.to change(controller.current_user.playlists, :count).by(1)
      end

      it 'redirects to the playlists index' do
        do_create
        expect(response).to redirect_to action: 'index'
      end
    end

    context 'whith invalid params' do
      before { allow_any_instance_of(Playlist).to receive(:save) { false } }

      it 'assigns the playlist as @playlist' do
        do_create
        expect(assigns[:playlist]).to be_a_new Playlist
      end

      it 'renders the new template' do
        do_create
        expect(response).to render_template 'new'
      end
    end
  end

  describe 'PUT update' do
    let (:playlist) { FactoryGirl.create(:playlist) }

    def do_update
      put :update, id: playlist.id.to_s, playlist: { name: 'Rock' }
    end

    context 'whith valid params' do
      it 'updates the playlist' do
        expect_any_instance_of(Playlist)
          .to receive(:update_attributes).with({'name' => 'Rock'})
        do_update
      end

      it 'redirects to the playlists index' do
        do_update
        expect(response).to redirect_to(action: 'index')
      end
    end

    context 'with invalid params' do
      before { allow_any_instance_of(Playlist).to receive(:save) { false } }

      it 'assigns the requested playlist as @playlist' do
        do_update
        expect(assigns[:playlist]).to eq playlist
      end

      it 'renders the edit template' do
        do_update
        expect(response).to render_template 'edit'
      end
    end
  end
end
