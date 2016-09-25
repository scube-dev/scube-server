class TrackSaver < BaseService
  attr_reader :track, :file

  def initialize track, file, sound_saver: SoundSaver
    @track        = track
    @file         = file
    @sound_saver  = sound_saver
  end

  def call
    return false unless sound_saver.call(track.sounds.new, file) if file
    track.save
  end

private

  attr_reader :sound_saver
end
