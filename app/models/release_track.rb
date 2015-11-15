class ReleaseTrack < ActiveRecord::Base
  belongs_to :release
  belongs_to :track

  validates :release, presence: true
  validates :track, presence: true
  validates :number, numericality: {
    only_integer: true,
    greater_than: 0
  }
end
