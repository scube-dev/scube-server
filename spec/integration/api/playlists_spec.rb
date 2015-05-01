describe 'API playlists' do
  include AcceptanceHelpers

  before { api_sign_in }

  it 'lists playlists' do
    playlist = create :playlist
    get api_playlists_path, format: :json

    expect(json).to match [
      a_hash_including(
        id:   an_instance_of(Fixnum),
        name: playlist[:name]
      )
    ]
  end

  it 'creates playlist' do
    playlist = attributes_for :playlist
    post api_playlists_path,
      format: :json,
      playlist: playlist

    expect(json).to match(
      id:   an_instance_of(Fixnum),
      name: playlist[:name]
    )
  end
end
