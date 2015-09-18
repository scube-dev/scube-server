class Playlist < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true

  def to_s
    name
  end
end
