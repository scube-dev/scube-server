require 'spec_helper'

describe API::SessionsController do
  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }

    def do_create
      post :create, format: :json, session: {
        email:    user.email,
        password: user.password
      }
    end

    context 'with valid credentials' do
      before { do_create }

      it 'signs the user in' do
        expect(controller.current_user).to eq user
      end

      it 'assigns the user' do
        expect(assigns[:user]).to eq user
      end
    end

    [:email, :password].each do |attr|
      context "with invalid credentials (#{attr})" do
        before do
          allow(user).to receive(attr).and_return(user.send(attr) + '_INVALID')
          do_create
        end

        it 'returns a not found response' do
          expect(response).to be_not_found
        end

        it 'returns an empty body' do
          expect(response.body).to be_empty
        end

        it 'assigns no user' do
          expect(assigns[:user]).to be_nil
        end
      end
    end
  end
end
