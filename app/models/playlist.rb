class Playlist < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name

  validates_presence_of :user
  validates_presence_of :name
end
