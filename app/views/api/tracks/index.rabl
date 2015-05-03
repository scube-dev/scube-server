collection @tracks, root: :tracks, object_root: false

extends 'api/tracks/show'

node(:sound_url, if: ->(t) { t.sound? }) { |t| api_sound_url t.sound }
