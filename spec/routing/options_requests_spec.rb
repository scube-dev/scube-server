require 'spec_helper'

describe '/api OPTIONS requests routing' do
  it 'routes to API::ApplicationController#cor_preflight' do
    expect(options: '/api/some_route')
      .to route_to(
        controller: 'api/application',
        action: 'cor_preflight',
        all: 'some_route'
      )
  end
end
