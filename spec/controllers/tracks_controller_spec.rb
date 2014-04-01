require 'spec_helper'

describe TracksController do
  include UserControllerHelpers

  before do
    sign_in
  end

  describe 'GET show' do
    it 'assigns the requested track as @track' do
      track = FactoryGirl.create(:track)
      get :show, id: track.id.to_s
      expect(assigns[:track]).to eq track
    end
  end

  describe 'GET new' do
    it 'assigns a new track as @track' do
      get :new
      expect(assigns[:track]).to be_a_new Track
    end
  end

  describe 'POST create new' do
    def do_create
      post :create, track: FactoryGirl.attributes_for(:track).merge({
        file: fixture_file_upload(
          "#{Rails.root}/spec/fixtures/test.mp3",
          'audio/mpeg'
        )
      })
    end

    context 'whith valid params' do
      it 'creates a new track' do
        expect {
          do_create
        }.to change(Track, :count).by(1)
      end

      it 'redirects to the track page' do
        do_create
        expect(response).to redirect_to Track.last
      end
    end

    context 'whith invalid params' do
      before do
        allow_any_instance_of(Track).to receive(:save) { false }
      end

      it 'assigns the track as @track' do
        do_create
        expect(assigns[:track]).to be_a_new Track
      end

      it 'renders the new template' do
        do_create
        expect(response).to render_template 'new'
      end
    end
  end
end
