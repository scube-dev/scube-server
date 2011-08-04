class User < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return false if user.nil?
    #FIXME use bcrypt
    return user if user.password == password
  end
end
