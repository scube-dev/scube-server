class Track < ActiveRecord::Base
  has_many :sounds

  attr_accessible :name, :file

  validates_presence_of :name

  def file=(file)
    sounds.build({:file => file})
  end

  def sound
    sounds.first
  end

  def sound?
    sounds.any?
  end

  def self.latest
    Track.order('created_at DESC')
  end
end
