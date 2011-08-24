require 'spec_helper'

describe PlaylistsController do
  before do
    controller.current_user = Factory.create(:user)
  end

  describe 'GET index' do
    it 'assigns all playlists as @playlists' do
      playlist = Factory.create(:playlist)
      get :index
      assigns[:playlists].should == [playlist]
    end
  end

  describe 'GET new' do
    it 'assigns a new playlist as @playlist' do
      get :new
      assigns[:playlist].should be_a_new(Playlist)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested playlist as @playlist' do
      playlist = Factory.create(:playlist)
      get :edit, :id => playlist.id.to_s
      assigns[:playlist].should == playlist
    end
  end

  describe 'POST create' do
    context 'whith valid params' do
      it 'creates a new playlist' do
        expect {
          post :create, :playlist => Factory.attributes_for(:playlist)
        }.to change(Playlist, :count).by(1)
      end

      it 'redirects to the playlists index' do
        post :create, :playlist => Factory.attributes_for(:playlist)
        response.should redirect_to(:action => 'index')
      end
    end

    context 'whith invalid params' do
      before { Playlist.any_instance.stub(:save).and_return(false) }

      it 'assigns the playlist as @playlist' do
        post :create, :playlist => {}
        assigns[:playlist].should be_a_new(Playlist)
      end

      it 'renders the new template' do
        post :create, :playlist => {}
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    let (:playlist) { Factory.create(:playlist) }

    def do_update
      put :update, :id => playlist.id.to_s, :playlist => { :name => 'Rock' }
    end

    context 'whith valid params' do
      it 'updates the playlist' do
        Playlist.any_instance.should_receive(:update_attributes).
          with({'name' => 'Rock'})
        do_update
      end

      it 'redirects to the playlists index' do
        do_update
        response.should redirect_to(:action => 'index')
      end
    end

    context 'with invalid params' do
      before { Playlist.any_instance.stub(:save).and_return(false) }

      it 'assigns the requested playlist as @playlist' do
        do_update
        assigns[:playlist].should == playlist
      end

      it 'renders the edit template' do
        do_update
        response.should render_template('edit')
      end
    end
  end
end
