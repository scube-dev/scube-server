require 'spec_helper'

describe Api::TracksController do
  include UserControllerHelpers

  before do
    sign_in
  end

  describe 'GET index' do
    before do
      Factory.create(:track_with_sound)
      Factory.create(:track_with_sound)
    end

    def do_get
      get :index, :format => :json
      JSON response.body
    end

    it 'lists all tracks' do
      do_get.should have(2).items
    end

    it 'lists tracks with their id' do
      do_get.each { |p| p.should include 'id' }
    end

    it 'lists tracks with their name' do
      do_get.each { |p| p.should include 'name' }
    end

    it 'lists tracks with sound URL' do
      do_get.each { |p| p.should include 'sound_url' }
    end
  end
end
