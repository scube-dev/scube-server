class Track < ActiveRecord::Base
  has_many :sounds

  validates_presence_of :name

  class << self
    def latest
      Track.order(created_at: :desc)
    end
  end

  def to_s
    name
  end

  def file= file
    sounds.build file: file
  end

  def sound
    sounds.first
  end

  def sound?
    sounds.any?
  end
end
