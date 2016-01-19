RSpec.describe 'Authors' do
  let(:author)  { create_author }
  subject       { response }

  before { sign_in }

  describe 'index' do
    before { author }

    it 'lists authors' do
      jget authors_path
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

  describe 'update' do
    let(:name)    { 'new name' }
    let(:author)  { create_author }

    before { jput author_path(author), author: { name: name } }

    it 'responds with no content status' do
      expect(response).to have_http_status 204
    end

    it 'updates the author' do
      jget author_path author[:id]
      expect(json[:author]).to include(
        name: 'new name'
      )
    end

    context 'when author is invalid' do
      let(:name) { '' }

      it 'responds with unprocessable entity status' do
        expect(response).to have_http_status 422
      end

      it 'returns errors' do
        expect(json :any).to match(
          name: [an_instance_of(String)]
        )
      end
    end
  end
end
