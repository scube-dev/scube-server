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

  describe 'playlists create' do
    let(:playlist) { attributes_for :playlist }

    before { post api_playlists_path, format: :json, playlist: playlist }

    it 'responds with created status' do
      expect(response).to have_http_status 201
    end

    it 'returns the playlist' do
      expect(json).to match(
        playlist: {
          id:   an_instance_of(Fixnum),
          name: playlist[:name]
        }
      )
    end

    it 'creates the playlist' do
      get response.location, format: :json
      expect(json[:playlist]).to include playlist
    end

    context 'when playlist is invalid' do
      let(:playlist) { attributes_for :playlist, name: '' }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status 422
      end

      it 'returns errors' do
        expect(json :any).to match(
          name: [an_instance_of(String)]
        )
      end
    end
  end

  describe 'playlist update' do
    let(:name)      { 'new name' }
    let(:playlist)  { create :playlist }

    before do
      put api_playlist_path(playlist), format: :json, playlist: {
        name: name
      }
    end

    it 'responds with no content status' do
      expect(response).to have_http_status 204
    end

    it 'updates the playlist' do
      get api_playlist_path playlist, format: :json
      expect(json[:playlist]).to include(
        name: 'new name'
      )
    end

    context 'when playlist is invalid' do
      let(:name) { '' }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status 422
      end

      it 'returns errors' do
        expect(json :any).to match(
          name: [an_instance_of(String)]
        )
      end
    end
  end

  it 'destroys a playlist' do
    playlist = create :playlist
    expect { delete api_playlist_path(playlist), format: :json }
      .to change { get api_playlist_path playlist, format: :json }
      .from(200).to 404
  end
end
