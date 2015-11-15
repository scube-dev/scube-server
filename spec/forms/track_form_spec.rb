RSpec.describe TrackForm do
  let(:track)     { attributes_for :track }
  let(:author)    { attributes_for :author }
  subject(:form)  { described_class.new {} }

  describe '#authors=' do
    context 'when given author name does not exist' do
      it 'builds a new author for the track' do
        form.authors = [author]
        expect(form.record.authors[0]).to be_an(Author).and be_new_record
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
end
