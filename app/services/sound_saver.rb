class SoundSaver < BaseService
  attr_reader :sound, :file

  def initialize sound, file
    @sound  = sound
    @file   = file
  end

  def call
    sound.errors[:sha256] << 'No file given' and return false unless file
    sound.sha256 = Digest::SHA256.file(file.path).hexdigest
    FileUtils.mv file.path, sound.path
    sound.mime_type = file.content_type
    sound.save
  end
end
