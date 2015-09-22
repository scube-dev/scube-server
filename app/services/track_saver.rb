class TrackSaver
  class << self
    def call *args
      new(*args).call
    end
  end

  attr_reader :track, :file

  def initialize track, file
    @track  = track
    @file   = file
  end

  def call
    if file
      return false unless sound_saver = SoundSaver.new(track.sounds.new, file).call
    end
    track.save
  end
end
