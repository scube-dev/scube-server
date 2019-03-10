class TrackAuthor < ApplicationRecord
  belongs_to :track
  belongs_to :author
end
