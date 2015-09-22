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
    before { jget api_track_path track }

    it 'shows a track' do
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

    context 'when track has authors' do
      let(:author)  { create :author }
      let!(:track)  { create :track, authors: [author] }

      it 'includes authors' do
        expect(json[:track]).to include authors: [{ name: author.name }]
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

    context 'when track has authors' do
      let(:author)  { attributes_for :author }
      let(:track)   { attributes_for(:track).merge authors: [author] }

      it 'creates related authors' do
        expect(json[:track]).to include authors: [author]
      end
    end
  end
end
