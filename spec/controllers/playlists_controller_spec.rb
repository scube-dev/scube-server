require 'spec_helper'

describe PlaylistsController do
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
    let(:playlist) { mock_model(Playlist).as_null_object }
    before { Playlist.stub(:new).and_return(playlist) }

    it 'creates a new playlist' do
      Playlist.should_receive(:new).
        with(Factory.attributes_for(:playlist)).
        and_return(playlist)
      post :create, :playlist => Factory.attributes_for(:playlist)
    end

    it 'saves the playlist' do
      playlist.should_receive(:save)
      post :create, :playlist => {}
    end

    context 'when the playlist saves successfully' do
      it 'redirects to the playlists index' do
        post :create, :playlist => {}
        response.should redirect_to(:action => 'index')
      end
    end

    context 'when the playlist fails to save' do
      before do
        playlist.stub(:save).and_return(false)
      end

      it 'assigns the playlist as @playlist' do
        post :create, :playlist => {}
        assigns[:playlist].should eq(playlist)
      end

      it 'renders the new template' do
        post :create, :playlist => {}
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    it 'updates the playlist' do
      playlist = Factory.create(:playlist)
      Playlist.any_instance.should_receive(:update_attributes).
        with({'name' => 'Rock'})
      put :update, :id => playlist.id.to_s, :playlist => {:name => 'Rock'}
    end

    it 'assigns the requested playlist as @playlist' do
      playlist = Factory.create(:playlist)
      put :update, :id => playlist.id.to_s, :playlist => {:name => 'Rock'}
      assigns[:playlist].should == playlist
    end

    context 'when the playlist updates successfully' do
      it 'redirects to the playlists index' do
        playlist = Factory.create(:playlist)
        put :update, :id => playlist.id.to_s, :playlist => Factory.attributes_for(:playlist)
        response.should redirect_to(:action => 'index')
      end
    end
  end
end
