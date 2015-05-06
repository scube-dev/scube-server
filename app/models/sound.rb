class Sound < ActiveRecord::Base
  belongs_to :track

  validates_presence_of :sha256
  validates_presence_of :mime_type

  def path
    "#{Rails.configuration.sounds_path}/#{sha256}"
  end

  def file= file
    self.errors[:sha256] << 'No file given' and return unless file
    self.sha256 = Digest::SHA256.file(file.path).hexdigest
    FileUtils.cp file.path, path
    self.mime_type = file.content_type
  end
end
