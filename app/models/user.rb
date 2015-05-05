class User < ActiveRecord::Base
  include BCrypt

  attr_reader :password

  has_many :playlists
  has_many :keys

  validates :email,
    presence: true,
    uniqueness: true
  validates :password,
    presence: true,
    confirmation: true
  validates_presence_of :password_hash

  def password= plain_password
    @password = plain_password
    self.password_hash = Password.create(plain_password)
  end

  def authenticate? password
    Password.new(password_hash) == password
  end
end
