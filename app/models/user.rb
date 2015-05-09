class User < ActiveRecord::Base
  has_secure_password

  has_many :playlists
  has_many :keys

  validates :email,
    presence: true,
    uniqueness: true

  def authenticate? password
    !!authenticate(password)
  end
end
