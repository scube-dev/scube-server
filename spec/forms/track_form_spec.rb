RSpec.describe TrackForm do
  subject(:form) { described_class.new {} }

  describe '#authors=' do
    let(:author) { attributes_for :author }

    context 'when given author name does not exist' do
      it 'builds a new author for the track' do
        form.authors = [author]
        expect(form.record.authors[0])
          .to be_an(Author)
          .and be_new_record
      end
    end

    context 'when given author name is known' do
      let(:known_author) { create :author, name: author[:name] }

      before { known_author }

      it 'associates the existing record' do
        form.authors = [author]
        expect(form.record.authors[0]).to eq known_author
      end
    end
  end

  describe '#release=' do
    let(:release) { attributes_for :release }

    it 'builds a release track' do
      form.release = release.merge track_number: 42
      expect(form.record.release_tracks)
        .to include an_instance_of ReleaseTrack
    end

    it 'builds the release track with given track number' do
      form.release = release.merge track_number: 42
      expect(form.record.release_tracks)
        .to include an_object_having_attributes number: 42
    end

    it 'builds the release track with given release' do
      form.release = release.merge track_number: 42
      expect(form.record.release_tracks[0].release)
        .to be_a(Release)
        .and be_new_record
        .and have_attributes release
    end

    context 'when given release exists' do
      let(:release) { create :release }

      it 'associates the existing release' do
        form.release = release.attributes.merge track_number: 42
        expect(form.record.release_tracks[0].release)
          .to eq(release)
          .and be_persisted
      end
    end
  end
end
