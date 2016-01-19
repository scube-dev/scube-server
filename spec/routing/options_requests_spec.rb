RSpec.describe 'OPTIONS requests routing' do
  it 'routes to ApplicationController#cor_preflight' do
    expect(options: '/some_route')
      .to route_to(
        controller: 'application',
        action: 'cor_preflight',
        all: 'some_route'
      )
  end
end
