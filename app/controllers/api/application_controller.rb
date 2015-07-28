module API
  class ApplicationController < ::ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    skip_before_filter :verify_authenticity_token
    skip_before_filter :authenticate!, only: %i[cor_preflight ping]

    before_filter :cor_filter
    before_filter :json_filter!, except: :cor_preflight

    def not_found
      head :not_found
    end

    def cor_filter
      headers['Access-Control-Allow-Origin'] = request.headers['Origin'] ?
        request.headers['Origin'] :
        ''
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Expose-Headers'] = 'Content-Length'
    end

    def cor_preflight
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
      headers['Access-Control-Allow-Headers'] =
        'Authorization, Content-Type, Content-Length, X-Requested-With'

      head :ok
    end

    def ping
      ping_response
    end

    def ping_auth
      ping_response
    end

  private

    def authenticate!
      if key = authenticate_with_http_token { |t| Key.authenticate(t) }
        self.current_user = key.user
      end
      head :unauthorized if current_user.nil?
    end

    def json_filter!
      if request.format.json? || request.accepts.include?(:json)
        request.format = :json
      else
        head :not_acceptable, content_type: 'application/json'
      end
    end

    def ping_response
      render json: { pong: true }
    end
  end
end
