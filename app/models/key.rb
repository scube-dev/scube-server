class Key < ApplicationRecord
  belongs_to :user

  has_secure_token :token

  validates :name, presence: true
  validates :token, uniqueness: true

  class << self
    def authenticate token
      find_by_token token
    end
  end
end
