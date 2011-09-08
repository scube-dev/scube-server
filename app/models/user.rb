require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_reader :password
  attr_accessible :email, :password, :password_confirmation

  has_many :playlists

  validates :email,
    :presence => true,
    :uniqueness => true
  validates_presence_of :password_hash
  validates_confirmation_of :password

  def password=(plain_password)
    @password = plain_password
    self.password_hash = Password.create(plain_password)
  end

  def authenticate?(password)
    Password.new(password_hash) == password
  end
end
