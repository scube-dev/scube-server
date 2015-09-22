describe 'API tracks' do
  let(:track) { create_track }
  subject     { response }

  before { api_sign_in }

  describe 'index' do
    before { track }

    it 'lists tracks' do
      jget api_tracks_path
      expect(json).to eq(
        tracks: [
          {
            id:   track[:id],
            name: track[:name]
          }
        ]
      )
    end
  end

  describe 'show' do
    it 'shows a track' do
      jget api_track_path track
      expect(json).to eq(
        track: {
          id:   track[:id],
          name: track[:name]
        }
      )
    end

    context 'when track has a sound' do
      let!(:track) { create_track attributes_for :track_with_file_upload }

      it 'includes sound path' do
        expect(json[:track]).to include :sound_path
      end
    end
  end

  describe 'create' do
    before { create_track track }

    it { is_expected.to have_http_status 201 }

    it 'creates a track' do
      jget response.location
      expect(json).to include :track
    end

    it 'returns the track' do
      expect(json).to include :track
    end

    context 'when track has a sound' do
      let!(:track) { attributes_for :track_with_file_upload }

      it 'creates related sound' do
        expect(json[:track]).to include :sound_path
      end
    end
  end
end
