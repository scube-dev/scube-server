describe 'API tracks' do
  include AcceptanceHelpers

  let(:track)       { create :track_with_sound }
  let(:other_track) { create :track }

  before { api_sign_in and track and other_track }

  it 'lists tracks' do
    get api_tracks_path, format: :json
    expect(json).to eq(
      tracks: [
        {
          id:         track.id,
          name:       track.name,
          sound_url:  api_sound_url(track.sound)
        },
        {
          id:         other_track.id,
          name:       other_track.name
        }
      ]
    )
  end

  it 'shows a track' do
    get api_track_path track, format: :json
    expect(json).to eq(
      track: {
        id:   track.id,
        name: track.name
      }
    )
  end
end
