require 'spec_helper'

describe TracksController do
  describe 'GET show' do
    it 'assigns the requested track as @track' do
      track = Factory.create(:track)
      get :show, :id => track.id.to_s
      assigns[:track].should == track
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
    before { Track.stub(:new).and_return(track) }

    it 'creates a new track' do
      Track.should_receive(:new).
        with(Factory.attributes_for(:track)).
        and_return(track)
      post :create, :track => Factory.attributes_for(:track)
    end

    it 'saves the track' do
      track.should_receive(:save)
      post :create, :track => {}
    end

    it 'saves the file uploaded for the track' do
      file = mock(Rack::Test::UploadedFile)
      track.should_receive(:uploaded_file=).with(file)
      post :create, :track => { :file => file }
    end

    context 'when the track saves successfully' do
      it 'redirects to the track page' do
        post :create, :track => Factory.attributes_for(:track)
        response.should redirect_to(track)
      end
    end

    context 'when the track fails to save' do
      before do
        track.stub(:save).and_return(false)
      end

      it 'assigns the track as @track' do
        post :create, :track => {}
        assigns[:track].should == track
      end

      it 'renders the new template' do
        post :create, :track => {}
        response.should render_template('new')
      end
    end

  end
end
