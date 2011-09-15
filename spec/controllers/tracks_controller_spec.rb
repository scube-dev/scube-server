require 'spec_helper'

describe TracksController do
  before do
    controller.current_user = Factory.create(:user)
  end

  describe 'GET show' do
    it 'assigns the requested track as @track' do
      track = Factory.create(:track)
      get :show, :id => track.id.to_s
      assigns[:track].should == track
    end
  end

  describe 'GET download' do
    let(:track) { Factory.create(:track) }

    it 'streams the requested track' do
      get :download, :id => track.id.to_s
      response.should be_success
    end

    it 'returns the track mime-type as content-type' do
      get :download, :id => track.id.to_s
      response.content_type.should == track.mime_type
    end
  end

  describe 'GET new' do
    it 'assigns a new track as @track' do
      get :new
      assigns[:track].should be_a_new(Track)
    end
  end

  describe 'POST create' do
    let(:track) { mock_model(Track).as_null_object }
    let(:file) {
      fixture_file_upload("#{Rails.root}/spec/fixtures/test.mp3", 'audio/mpeg')
    }
    before { Track.stub(:new).and_return(track) }

    it 'creates a new track' do
      attributes = Factory.attributes_for(:track)
      Track.should_receive(:new).
        with({:name => attributes[:name]}).
        and_return(track)
      post :create, :track => {
        :name => attributes[:name],
        :file => file
      }
    end

    it 'saves the track with a file' do
      track.should_receive(:save_with_file).
        with(file, 'audio/mpeg')
      post :create, :track => { :file => file }
    end

    context 'when the track saves successfully' do
      it 'redirects to the track page' do
        post :create, :track => { :file => file }
        response.should redirect_to(track)
      end
    end

    context 'when the track fails to save' do
      before do
        track.stub(:save_with_file).and_return(false)
      end

      it 'assigns the track as @track' do
        post :create, :track => { :file => file }
        assigns[:track].should == track
      end

      it 'renders the new template' do
        post :create, :track => { :file => file }
        response.should render_template('new')
      end
    end
  end
end
