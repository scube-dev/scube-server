class Key < ActiveRecord::Base
  belongs_to :user

  has_secure_token :token

  validates :user, presence: true
  validates :name, presence: true
  validates :token, uniqueness: true

  class << self
    def authenticate token
      find_by_token token
    end
  end
end
