require 'spec_helper'

describe '/api OPTIONS requests routing' do
  it 'routes to Api::ApplicationController#cor_preflight' do
    { :options => '/api/v0' }.should route_to(
      :controller => 'api/application',
      :action => 'cor_preflight',
      :all => 'v0'
    )
  end
end
