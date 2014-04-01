require 'spec_helper'

feature 'API sign in' do
  let(:user)  { FactoryGirl.create(:user) }

  def do_create
    post api_sessions_path, :format => :json, :session => {
      :email    => user.email,
      :password => user.password
    }
  end

  scenario 'signs the user in with valid credentials' do
    do_create

    response.should be_success
    (JSON response.body).should include 'id'
  end

  [:email, :password].each do |attr|
    scenario "rejects authentication with invalid credentials (#{attr})" do
      user.stub(attr => user.send(attr) + '_INVALID')
      do_create

      response.should be_not_found
      response.body.should be_empty
    end
  end
end
