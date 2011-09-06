require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'assigns a new user as @user' do
      get :new
      assigns[:user].should be_a_new(User)
    end
  end

  describe 'POST create' do
    context 'whith valid params' do
      it 'creates a new user' do
        expect {
          post :create, :user => Factory.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it 'signs the user in' do
        post :create, :user => Factory.attributes_for(:user)
        controller.current_user.should_not be_nil
      end

      it 'redirects to the home page' do
        post :create, :user => Factory.attributes_for(:user)
        response.should redirect_to(:root)
      end
    end

    context 'whith invalid params' do
      before { User.any_instance.stub(:save).and_return(false) }

      it 'assigns the user as @user' do
        post :create, :user => {}
        assigns[:user].should be_a_new(User)
      end

      it 'renders the new template' do
        post :create, :user => {}
        response.should render_template('new')
      end
    end
  end
end
