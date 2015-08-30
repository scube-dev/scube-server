class Track < ActiveRecord::Base
  has_many :sounds

  validates_presence_of :name

  class << self
    def with_sounds
      includes :sounds
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
