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
    return false unless SoundSaver.new(track.sounds.new, file).call if file
    track.save
  end
end
