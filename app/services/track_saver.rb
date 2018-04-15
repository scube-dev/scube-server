class TrackSaver < Service
  attr_reader :track, :file

  def initialize track, file, sound_saver: SoundSaver
    @track        = track
    @file         = file
    @sound_saver  = sound_saver
  end

  def call
    if file
      sound = track.sounds.new
      unless sound_saver.call sound, file
        @track.errors.messages.merge! file: sound.errors.messages
        return false
      end
    end
    track.save
  end

private

  attr_reader :sound_saver
end
