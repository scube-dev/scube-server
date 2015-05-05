class Key < ActiveRecord::Base
  belongs_to :user

  has_secure_token :token

  validates :name, presence: true
end
