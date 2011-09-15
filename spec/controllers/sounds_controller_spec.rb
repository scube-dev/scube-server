require 'spec_helper'

describe SoundsController do
  before do
    controller.current_user = Factory.create(:user)
  end

  describe 'GET show' do
    let(:sound) { Factory.create(:sound) }

    def do_show
      get :show, :id => sound.id
    end

    it 'sends the sound file as the response body' do
      do_show
      response.body.should == File.read(sound.path)
    end

    it 'sets the sound file mime-type as the response content-type' do
      do_show
      response.content_type.should == sound.mime_type
    end
  end
end
