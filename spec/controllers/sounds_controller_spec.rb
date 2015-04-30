describe SoundsController do
  include UserControllerHelpers

  before { sign_in }

  describe 'GET show' do
    let(:sound) { FactoryGirl.create(:sound) }

    def do_show
      get :show, id: sound.id
    end

    it 'sets the sound file content as the response body' do
      do_show
      expect(response.body).to eq File.read(sound.path, encoding: 'BINARY')
    end

    it 'sets the sound mime-type as the response content-type' do
      do_show
      expect(response.content_type).to eq sound.mime_type
    end
  end
end
