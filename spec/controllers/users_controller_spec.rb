require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'assigns a new user as @user' do
      get :new
      expect(assigns[:user]).to be_a_new(User)
    end
  end

  describe 'POST create' do
    context 'whith valid params' do
      it 'creates a new user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it 'signs the user in' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(controller.current_user).not_to be_nil
      end

      it 'redirects to the home page' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to :root
      end
    end

    context 'whith invalid params' do
      before { allow_any_instance_of(User).to receive(:save) { false } }

      it 'assigns the user as @user' do
        post :create, user: {}
        expect(assigns[:user]).to be_a_new User
      end

      it 'renders the new template' do
        post :create, user: {}
        expect(response).to render_template 'new'
      end
    end
  end
end
