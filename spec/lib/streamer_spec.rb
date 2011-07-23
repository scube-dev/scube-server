require 'spec_helper'

describe Streamer do
  describe '#each' do
    let(:stream) { Streamer.new("#{Rails.root}/spec/fixtures/test.mp3") }

    it 'returns file content' do
      chunks = ''
      stream.each { |c| chunks << c }
      chunks.should == File.read("#{Rails.root}/spec/fixtures/test.mp3")
    end

    it 'returns content in multiple chunks' do
      count = 0
      stream.each { count += 1 }
      count.should be >= 2
    end
  end
end
