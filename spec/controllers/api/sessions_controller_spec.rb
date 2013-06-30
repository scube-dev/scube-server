require 'spec_helper'

describe API::SessionsController do
  describe 'POST create' do
    let(:user) { Factory.create(:user) }

    def do_create
      post :create, :format => :json, :session => {
        :email    => user.email,
        :password => user.password
      }
    end

    context 'with valid credentials' do
      before do
        do_create
      end

      it 'signs the user in' do
        controller.current_user.should == user
      end

      it 'assigns the user' do
        assigns[:user].should == user
      end
    end

    [:email, :password].each do |attr|
      context "with invalid credentials (#{attr})" do
        before do
          user.stub(attr => user.send(attr) + '_INVALID')
          do_create
        end

        it 'returns a not found response' do
          response.should be_not_found
        end

        it 'returns an empty body' do
          response.body.should be_empty
        end

        it 'assigns no user' do
          assigns[:user].should be_nil
        end
      end
    end
  end
end
