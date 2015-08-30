describe 'API tracks' do
  let(:track)       { create :track_with_sound }
  let(:other_track) { create :track }

  before { api_sign_in }

  describe 'index' do
    before { track and other_track }

    it 'lists tracks' do
      jget api_tracks_path
      expect(json).to eq(
        tracks: [
          {
            id:         track.id,
            name:       track.name,
            sound_path: api_sound_path(track.sound)
          },
          {
            id:         other_track.id,
            name:       other_track.name
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
          id:         track.id,
          name:       track.name,
          sound_path: api_sound_path(track.sound)
        }
      )
    end
  end
end
