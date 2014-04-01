require 'spec_helper'

describe ApplicationController do
  let(:user) { FactoryGirl.create(:user) }

  describe '#current_user=' do
    it 'stores the user id in the session as :user_id' do
      controller.current_user = user
      expect(session[:user_id]).to eq user.id
    end
  end

  describe '#current_user' do
    context 'when session[:user_id] is set' do
      it 'returns the User instance from the session' do
        session[:user_id] = user.id
        expect(controller.current_user).to eq user
      end
    end
  end
end
