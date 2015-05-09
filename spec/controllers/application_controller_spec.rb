describe ApplicationController do
  let(:user) { create :user }

  describe '#current_user=' do
    it 'stores the user id in the session as :user_id' do
      controller.current_user = user
      expect(session[:user_id]).to eq user.id
    end
  end

  describe '#current_user' do
    context 'when :user_id is set in session' do
      before { session[:user_id] = user.id }

      it 'returns the related user instance' do
        expect(controller.current_user).to eq user
      end
    end

    context 'when :user_id is not set in session' do
      it 'returns nil' do
        expect(controller.current_user).to be nil
      end
    end
  end
end
