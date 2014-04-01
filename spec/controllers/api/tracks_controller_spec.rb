require 'spec_helper'

describe API::TracksController do
  include UserControllerHelpers

  before { sign_in }

  describe 'GET index' do
    render_views

    before do
      FactoryGirl.create(:track_with_sound)
      FactoryGirl.create(:track_with_sound)
    end

    def do_get
      get :index, format: :json
      JSON response.body
    end

    it 'lists all tracks' do
      expect(do_get).to have(2).items
    end

    it 'lists tracks with their id' do
      do_get.each { |p| expect(p).to include 'id' }
    end

    it 'lists tracks with their name' do
      do_get.each { |p| expect(p).to include 'name' }
    end

    it 'lists tracks with sound URL' do
      do_get.each { |p| expect(p).to include 'sound_url' }
    end
  end
end
