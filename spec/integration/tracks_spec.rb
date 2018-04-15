RSpec.describe 'Tracks' do
  let(:track) { create_track }
  subject     { response }

  before { sign_in }

  describe 'index' do
    before { track }

    it 'lists tracks' do
      jget tracks_path
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
    before { jget track_path track }

    it 'shows a track' do
      expect(json).to eq(
        track: {
          id:   track[:id],
          name: track[:name]
        }
      )
    end

    context 'when track has a sound' do
      let!(:track) { create_track attributes_for :track, :with_file_upload }

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

    context 'when track has a file' do
      let(:track) { attributes_for :track, :with_file_upload }

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

    context 'when track has release information' do
      let(:release) { attributes_for :release }
      let(:track) do
        attributes_for(:track).merge release: release.merge(track_number: 42)
      end

      it 'creates related release' do
        expect(json[:track]).to include releases: [release]
      end
    end

    context 'when track is invalid' do
      let(:track) { attributes_for :track, name: nil }

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
end
