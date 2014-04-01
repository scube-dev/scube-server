require 'spec_helper'

describe API::ApplicationController do
  include UserControllerHelpers

  before do
    sign_in
  end

  context 'CORS: Cross-Origin Ressource Sharing' do
    before do
      request.headers['Origin'] = 'http://origin.example/'
    end

    context 'preflight' do
      controller(API::ApplicationController) do
        alias_method :index, :cor_preflight
      end

      def options(action)
        process action, 'OPTIONS'
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
      controller(API::ApplicationController) do
        def index
          head :ok
        end
      end

      it 'sets Access-Control-Allow-Origin header' do
        get :index
        response.headers['Access-Control-Allow-Origin']
          .should == request.headers['Origin']
      end
    end
  end
end
