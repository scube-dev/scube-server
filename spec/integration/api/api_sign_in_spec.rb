require 'spec_helper'

describe 'API sign in' do
  let(:user)  { FactoryGirl.create(:user) }

  def do_create
    post api_sessions_path, format: :json, session: {
      email:    user.email,
      password: user.password
    }
  end

  it 'signs the user in with valid credentials' do
    do_create

    expect(response).to be_success
    expect(JSON response.body).to include 'id'
  end

  [:email, :password].each do |attr|
    it "rejects authentication with invalid credentials (#{attr})" do
      allow(user).to receive(attr).and_return(user.send(attr) + '_INVALID')
      do_create

      expect(response).to be_not_found
      expect(response.body).to be_empty
    end
  end
end
