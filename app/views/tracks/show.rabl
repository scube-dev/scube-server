object @track

attribute :id
attribute :name

node(:sound_path, if: ->(t) { t.sound? }) { |t| sound_path t.sound }

child :authors, object_root: false, if: ->(t) { t.authors.any? } do
  attribute :name
end

child :releases, object_root: false, if: ->(t) { t.releases.any? } do
  attribute :name
  attribute :year
end
