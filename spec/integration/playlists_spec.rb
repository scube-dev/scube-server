RSpec.describe 'Playlists' do
  before { sign_in }

  it 'lists playlists' do
    playlist = create :playlist
    jget :playlists
    expect(json).to eq playlists: [{
      id: playlist.id,
      name: playlist.name
    }]
  end

  it 'shows a playlist' do
    playlist = create :playlist
    jget playlist_path playlist
    expect(json).to eq playlist: {
      id: playlist.id,
      name: playlist.name
    }
  end

  describe 'playlists create' do
    let(:playlist) { attributes_for :playlist }

    before { jpost :playlists, playlist: playlist }

    it 'responds with created status' do
      expect(response).to have_http_status 201
    end

    it 'returns the playlist' do
      expect(json).to match playlist: {
        id: Integer,
        name: playlist[:name]
      }
    end

    it 'creates the playlist' do
      jget response.location
      expect(json[:playlist]).to include playlist
    end

    context 'when playlist is invalid' do
      let(:playlist) { attributes_for :playlist, name: '' }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status 422
      end

      it 'returns errors' do
        expect(json :any).to match name: [String]
      end
    end
  end

  describe 'playlist update' do
    let(:name)      { 'new name' }
    let(:playlist)  { create :playlist }

    before { jput playlist_path(playlist), playlist: { name: name } }

    it 'responds with no content status' do
      expect(response).to have_http_status 204
    end

    it 'updates the playlist' do
      jget playlist_path playlist
      expect(json[:playlist]).to include name: 'new name'
    end

    context 'when playlist is invalid' do
      let(:name) { '' }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status 422
      end

      it 'returns errors' do
        expect(json :any).to match name: [String]
      end
    end
  end

  it 'destroys a playlist' do
    playlist = create :playlist
    expect { jdelete playlist_path playlist }
      .to change { jget playlist_path playlist }
      .from(200)
      .to 404
  end
end
