require 'spec_helper'

feature 'API playlists' do
  include UserIntegrationHelpers

  background do
    api_sign_in
  end

  scenario 'creates playlist' do
    playlist = FactoryGirl.attributes_for :playlist

    post api_playlists_path,
      format: :json,
      playlist: playlist

    json = JSON response.body

    json['id'].should be_a Fixnum
    json['name'].should == playlist[:name]
  end
end
