require 'spec_helper'

describe Api::ApplicationController do
  include UserControllerHelpers

  before do
    sign_in
  end

  context 'CORS: Cross-Origin Ressource Sharing' do
    before do
      request.env['Origin'] = 'http://origin.example/'
    end

    context 'preflight' do
      controller(Api::ApplicationController) do
        alias_method :index, :cor_preflight
      end

      def options(action)
        process action, nil, nil, nil, 'OPTIONS'
      end

      it 'sets Access-Control-Allow-Methods header' do
        options :index
        response.headers['Access-Control-Allow-Methods'].should ==
          'GET, POST, PUT, DELETE'
      end

      it 'sets Access-Control-Allow-Methods header' do
        options :index
        response.headers['Access-Control-Allow-Headers'].should ==
          'Content-Type, Content-Length, X-Requested-With'
      end
    end

    describe 'before filter' do
      controller(Api::ApplicationController) do
        def index
          head :ok
        end
      end

      it 'sets Access-Control-Allow-Origin header' do
        get :index
        response.headers['Access-Control-Allow-Origin'].should ==
          request.env['Origin']
      end
    end
  end
end
