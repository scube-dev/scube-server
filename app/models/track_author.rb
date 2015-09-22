class TrackAuthor < ActiveRecord::Base
  belongs_to :track
  belongs_to :author
end
