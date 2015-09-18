class Sound < ActiveRecord::Base
  belongs_to :track

  validates :sha256, presence: true
  validates :mime_type, presence: true

  def path
    "#{Rails.configuration.sounds_path}/#{sha256}"
  end

  def file= file
    errors[:sha256] << 'No file given' and return unless file
    self.sha256 = Digest::SHA256.file(file.path).hexdigest
    FileUtils.cp file.path, path
    self.mime_type = file.content_type
  end
end
