collection @tracks, root: :tracks, object_root: false

attribute :id
attribute :name

node(:sound_url, if: ->(t) { t.sound? }) { |t| api_sound_url t.sound }
