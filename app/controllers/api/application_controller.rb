class Api::ApplicationController < ApplicationController
  before_filter :cor_filter

  def cor_filter
    headers['Access-Control-Allow-Origin'] = request.headers['Origin']
  end

  def cor_preflight
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With'

    head :ok
  end
end
