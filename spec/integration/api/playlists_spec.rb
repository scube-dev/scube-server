describe 'API playlists' do
  include UserIntegrationHelpers

  before { api_sign_in }

  it 'creates playlist' do
    playlist = FactoryGirl.attributes_for :playlist

    post_via_redirect api_playlists_path,
      format: :json,
      playlist: playlist

    json = JSON response.body

    expect(json['id']).to be_a Fixnum
    expect(json['name']).to eq playlist[:name]
  end
end
