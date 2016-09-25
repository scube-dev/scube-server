RSpec.describe TrackSaver do
  include ActionDispatch::TestProcess

  let(:file)        { 'spec/fixtures/test.mp3'.freeze }
  let(:upload)      { fixture_file_upload file, 'audio/mpeg' }
  let(:track)       { TrackForm.new(attributes_for(:track).stringify_keys) }
  let(:sound_saver) { SoundSaver }

  subject :service do
    described_class.new track, upload, sound_saver: sound_saver
  end

  describe '#call' do
    it 'calls the sound saver with a new track sound and the file' do
      aggregate_failures do
        expect(sound_saver).to receive :call do |sound, file|
          expect(sound).to be_a_new_record
          expect(sound.track).to eq track.record
          expect(file).to eq file
        end
      end
      service.call
    end

    it 'saves the track' do
      service.call
      expect(track).to be_persisted
    end

    it 'returns true' do
      expect(service.call).to be true
    end

    context 'when the sound saver fails to save the sound' do
      before do
        allow(sound_saver).to receive(:call) { false }
      end

      it 'does not save the track' do
        service.call
        expect(track).not_to be_persisted
      end

      it 'returns false' do
        expect(service.call).to be false
      end
    end
  end
end
