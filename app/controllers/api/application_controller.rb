class Api::ApplicationController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate!, :only => [:cor_preflight]

  before_filter :cor_filter

  def cor_filter
    headers['Access-Control-Allow-Origin'] = request.headers['Origin']
    headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def cor_preflight
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With'

    head :ok
  end

  def authenticate!
    head :unauthorized if current_user.nil?
  end
end
