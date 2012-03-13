require 'spec_helper'

feature 'API cross origin request' do
  include UserIntegrationHelpers

  let(:user)    { Factory.create(:user) }
  let(:origin)  { 'http://origin.example/' }

  background do
    post sessions_path, :session => {
      :email    => user.email,
      :password => user.password
    }
  end

  scenario 'preflight request' do
    # FIXME: replace with a more stable/generic action
    # FIXME: request without redirect
    request_via_redirect(
      :options,
      api_v0_playlists_path(:format => :json),
      nil,
      { 'Origin' => origin }
    )

    response.headers['Access-Control-Allow-Origin'].should == origin
    response.headers['Access-Control-Allow-Credentials'].should == 'true'
    response.headers['Access-Control-Allow-Methods'].should ==
      'GET, POST, PUT, DELETE'
    response.headers['Access-Control-Allow-Headers'].should ==
      'Content-Type, X-Requested-With'
  end

  scenario 'basic request' do
    # FIXME: replace with a more stable/generic action
    get api_v0_playlists_path(:format => :json), nil, {
      'Origin' => origin
    }

    response.headers['Access-Control-Allow-Origin'].should == origin
    response.headers['Access-Control-Allow-Credentials'].should == 'true'
  end
end
