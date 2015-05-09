describe ApplicationController do
  let(:user) { create :user }

  describe '#current_user?' do
    context 'when no user is set' do
      it 'returns false' do
        expect(controller.current_user?).to be false
      end
    end

    context 'when an user is set' do
      before { controller.current_user = user }

      it 'returns true' do
        expect(controller.current_user?).to be true
      end
    end
  end
end
