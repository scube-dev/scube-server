RSpec.describe 'API authors' do
  let(:author)  { create_author }
  subject       { response }

  before { api_sign_in }

  describe 'index' do
    before { author }

    it 'lists authors' do
      jget api_authors_path
      expect(json).to eq(
        authors: [
          {
            id:   author[:id],
            name: author[:name]
          }
        ]
      )
    end
  end

  describe 'create' do
    before { author }

    it { is_expected.to have_http_status 201 }

    it 'creates an author' do
      jget response.location
      expect(json).to include :author
    end

    it 'returns the author' do
      expect(json).to include :author
    end
  end
end
