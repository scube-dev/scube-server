class User < ActiveRecord::Base
  has_secure_password

  has_many :keys
  has_many :playlists

  validates :email,     presence: true, uniqueness: true
  validates :password,  length: { minimum: 8 }, if: :password_digest_changed?

  def authenticate? password
    !!authenticate(password)
  end
end
