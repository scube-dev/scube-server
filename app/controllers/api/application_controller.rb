module API
  class ApplicationController < ::ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    skip_before_filter :verify_authenticity_token
    skip_before_filter :authenticate!, only: :cor_preflight

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
        'Content-Type, Content-Length, X-Requested-With'

      head :ok
    end

    def ping
      render json: { pong: 'ok' }
    end

    def authenticate!
      head :unauthorized if current_user.nil?
    end

    def json_filter!
      if request.format.json? || request.accepts.include?(:json)
        request.format = :json
      else
        head :not_acceptable, content_type: 'application/json'
      end
    end
  end
end
