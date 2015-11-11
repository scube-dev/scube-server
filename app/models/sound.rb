class Sound < ActiveRecord::Base
  belongs_to :track

  validates :sha256, presence: true, uniqueness: true
  validates :mime_type, presence: true

  def path
    "#{Rails.configuration.sounds_path}/#{sha256}"
  end
end
