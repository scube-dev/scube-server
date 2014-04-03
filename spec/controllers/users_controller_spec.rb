require 'spec_helper'

describe UsersController do
  let(:attributes) { FactoryGirl.attributes_for(:user) }

  describe 'GET new' do
    it 'assigns a new user as @user' do
      get :new
      expect(assigns[:user]).to be_a_new User
    end
  end

  describe 'POST create' do
    def do_post(params = {})
      post :create, user: attributes.merge(params)
    end

    context 'whith valid params' do
      it 'creates a new user' do
        expect {
          do_post
        }.to change(User, :count).by(1)
      end

      it 'signs the user in' do
        do_post
        expect(controller.current_user).not_to be_nil
      end

      it 'redirects to the home page' do
        do_post
        expect(response).to redirect_to :root
      end
    end

    context 'whith invalid params' do
      before { allow_any_instance_of(User).to receive(:save) { false } }

      it 'assigns the user as @user' do
        do_post
        expect(assigns[:user]).to be_a_new User
      end

      it 'renders the new template' do
        do_post
        expect(response).to render_template 'new'
      end
    end
  end
end
