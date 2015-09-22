object @track

attribute :id
attribute :name

node(:sound_path, if: ->(t) { t.sound? }) { |t| api_sound_path t.sound }

child :authors, object_root: false, if: ->(t) { t.authors.any? } do
  attribute :name
end
