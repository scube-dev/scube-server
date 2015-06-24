class Playlist < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :name

  def to_s
    name
  end
end
