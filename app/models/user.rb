require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation

  validates_presence_of :email

  validates :password,
    :presence     => true,
    :confirmation => true

  before_save :hash_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return false if user.nil?
    return user if Password.new(user.password_hash) == password
  end


  private

  def hash_password
    self.password_hash = bcrypt(password)
  end

  def bcrypt(string)
    Password.create(string)
  end
end
