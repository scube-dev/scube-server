describe 'API tracks' do
  include AcceptanceHelpers

  before { api_sign_in }

  it 'lists tracks' do
    track_1 = create :track_with_sound, name: 'Track 1'
    track_2 = create :track, name: 'Track 2'
    get api_tracks_path, format: :json

    expect(json).to eq [
      {
        id:         track_1.id,
        name:       'Track 1',
        sound_url:  api_sound_url(track_1.sound)
      },
      {
        id:         track_2.id,
        name:       'Track 2'
      }
    ]
  end

  it 'shows a track' do
    track = create :track
    get api_track_path track, format: :json

    expect(json).to match(
      id:   track.id,
      name: track.name
    )
  end
end
