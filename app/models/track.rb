class Track < ActiveRecord::Base
  has_many :sounds
  has_many :track_authors
  has_many :authors, through: :track_authors

  validates :name, presence: true

  class << self
    def with_sounds
      includes :sounds
    end
  end

  def sound
    sounds.first
  end

  def sound?
    sounds.any?
  end
end
