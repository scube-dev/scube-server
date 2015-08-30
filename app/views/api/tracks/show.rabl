object @track

attribute :id
attribute :name

node(:sound_path, if: ->(t) { t.sound? }) { |t| api_sound_path t.sound }
