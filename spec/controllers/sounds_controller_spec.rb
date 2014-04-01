require 'spec_helper'

describe SoundsController do
  include UserControllerHelpers

  before do
    sign_in
  end

  describe 'GET show' do
    let(:sound) { FactoryGirl.create(:sound) }

    def do_show
      get :show, :id => sound.id
    end

    it 'sets the sound file content as the response body' do
      do_show
      response.body.should == File.read(sound.path, :encoding => 'BINARY')
    end

    it 'sets the sound mime-type as the response content-type' do
      do_show
      response.content_type.should == sound.mime_type
    end
  end
end
