describe 'API playlists' do
  before { api_sign_in }

  it 'lists playlists' do
    playlist = create :playlist
    get api_playlists_path, format: :json
    expect(json).to eq(
      playlists: [{
        id:   playlist.id,
        name: playlist.name
      }]
    )
  end

  it 'shows a playlist' do
    playlist = create :playlist
    get api_playlist_path playlist, format: :json
    expect(json).to eq(
      playlist: {
        id:   playlist.id,
        name: playlist.name
      }
    )
  end

  it 'creates a playlist' do
    playlist = attributes_for :playlist
    post api_playlists_path, format: :json, playlist: playlist
    expect(json).to match(
      playlist: {
        id:   an_instance_of(Fixnum),
        name: playlist[:name]
      }
    )
  end

  it 'updates a playlist' do
    playlist = create :playlist
    put api_playlist_path(playlist), format: :json, playlist: {
      name: 'new name'
    }
    get api_playlist_path playlist, format: :json
    expect(json[:playlist]).to include(
      name: 'new name'
    )
  end
end
