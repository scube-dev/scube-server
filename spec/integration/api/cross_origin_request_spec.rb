require 'spec_helper'

feature 'API cross origin request' do
  include UserIntegrationHelpers

  let(:user)    { FactoryGirl.create(:user) }
  let(:origin)  { 'http://origin.example/' }

  background do
    post sessions_path, session: {
      email:    user.email,
      password: user.password
    }
  end

  scenario 'preflight request' do
    @integration_session.send(
      :process,
      :options,
      api_playlists_path(format: :json),
      nil,
      { 'Origin' => origin }
    )

    response.headers['Access-Control-Allow-Origin'].should == origin
    response.headers['Access-Control-Allow-Credentials'].should == 'true'
    response.headers['Access-Control-Allow-Methods'].should ==
      'GET, POST, PUT, DELETE'
    response.headers['Access-Control-Allow-Headers'].should ==
      'Content-Type, Content-Length, X-Requested-With'
  end

  scenario 'basic request' do
    # FIXME: replace with a more stable/generic action
    get api_playlists_path(format: :json), nil, {
      'Origin' => origin
    }

    response.headers['Access-Control-Allow-Origin'].should == origin
    response.headers['Access-Control-Allow-Credentials'].should == 'true'
    response.headers['Access-Control-Expose-Headers'].should == 'Content-Length'
  end

  scenario 'request without origin' do
    # FIXME: replace with a more stable/generic action
    get api_playlists_path(format: :json)

    response.headers['Access-Control-Allow-Origin'].should == ''
  end
end
