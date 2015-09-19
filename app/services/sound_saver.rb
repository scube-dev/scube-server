class SoundSaver
  class << self
    def call *args
      new(*args).call
    end
  end

  attr_reader :sound, :file

  def initialize sound, file, save: true
    @sound  = sound
    @file   = file
    @save   = save
  end

  def save?
    !!@save
  end

  def call
    sound.errors[:sha256] << 'No file given' and return false unless file
    sound.sha256 = Digest::SHA256.file(file.path).hexdigest
    FileUtils.mv file.path, sound.path
    sound.mime_type = file.content_type
    sound.save if save?
  end
end
