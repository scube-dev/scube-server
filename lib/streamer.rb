class Streamer
  def initialize(file)
    @file = file
  end

  def each
    f = File.new(@file, 'r')
    while data = f.read(4096) do
      yield data
    end
  end
end
