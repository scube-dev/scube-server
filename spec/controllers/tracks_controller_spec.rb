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

  describe 'GET new' do
    it 'assigns a new track as @track' do
      get :new
      assigns[:track].should be_a_new(Track)
    end
  end

  describe 'POST create' do
    let(:track)       { mock_model(Track).as_null_object }
    let(:attributes)  { Factory.attributes_for(:track).stringify_keys }

    before do
      Track.stub(:new).and_return(track)
    end

    def do_create
      post :create, :track => attributes
    end

    it 'creates a new track' do
      Track.should_receive(:new).with(attributes)
      do_create
    end

    it 'saves the track' do
      track.should_receive :save
      do_create
    end

    context 'when the track saves successfully' do
      it 'redirects to the track page' do
        do_create
        response.should redirect_to(track)
      end
    end

    context 'when the track fails to save' do
      before do
        track.stub(:save).and_return(false)
      end

      it 'assigns the track as @track' do
        do_create
        assigns[:track].should == track
      end

      it 'renders the new template' do
        do_create
        response.should render_template('new')
      end
    end
  end
end
