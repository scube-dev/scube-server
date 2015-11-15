class Release < ActiveRecord::Base
  validates :name, presence: true
  validates :year, numericality: { only_integer: true }
end
