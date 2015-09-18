class Key < ActiveRecord::Base
  belongs_to :user

  has_secure_token :token

  validates :name, presence: true

  class << self
    def authenticate token
      find_by_token token
    end
  end
end
