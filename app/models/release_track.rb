class ReleaseTrack < ApplicationRecord
  belongs_to :release
  belongs_to :track

  validates :number, numericality: {
    only_integer: true,
    greater_than: 0
  }
end
