describe API::ApplicationController do
  include UserControllerHelpers

  before { sign_in }

  context 'CORS: Cross-Origin Ressource Sharing' do
    before { request.headers['Origin'] = 'http://origin.example/' }

    context 'preflight' do
      controller(API::ApplicationController) do
        alias_method :index, :cor_preflight
      end

      def options(action)
        process action, 'OPTIONS'
      end

      it 'sets Access-Control-Allow-Methods header' do
        options :index
        expect(response.headers['Access-Control-Allow-Methods'])
          .to eq 'GET, POST, PUT, DELETE'
      end

      it 'sets Access-Control-Allow-Methods header' do
        options :index
        expect(response.headers['Access-Control-Allow-Headers'])
          .to eq 'Content-Type, Content-Length, X-Requested-With'
      end
    end

    describe 'before filter' do
      controller(API::ApplicationController) do
        def index
          head :ok
        end
      end

      it 'sets Access-Control-Allow-Origin header' do
        get :index
        expect(response.headers['Access-Control-Allow-Origin'])
          .to eq request.headers['Origin']
      end
    end
  end
end
