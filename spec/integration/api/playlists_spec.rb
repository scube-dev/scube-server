require 'spec_helper'

feature 'API playlists' do
  include UserIntegrationHelpers

  background { api_sign_in }

  scenario 'creates playlist' do
    playlist = FactoryGirl.attributes_for :playlist

    post api_playlists_path,
      format: :json,
      playlist: playlist

    json = JSON response.body

    expect(json['id']).to be_a Fixnum
    expect(json['name']).to eq playlist[:name]
  end
end
