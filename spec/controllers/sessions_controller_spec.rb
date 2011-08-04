require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'responds successfully' do
      response.should be_success
    end
  end

  describe 'POST create' do
    context 'when the user submit invalid credentials' do
      it 'renders the new template' do
        User.stub(:authenticate).and_return(false)
        post :create,
          :session => Factory.attributes_for(:user, :password => 'WRONG')
        response.should render_template('new')
      end
    end

    context 'when the user submit valid credentials' do
      let(:user) { Factory.create(:user) }
      before do
        User.stub(:authenticate).and_return(user)
      end

      it 'signs the user in' do
        post :create, :session => Factory.attributes_for(:user)
        controller.current_user.should == user
      end

      it 'redirects to the home page' do
        post :create, :session => Factory.attributes_for(:user)
        response.should redirect_to(:root)
      end
    end
  end

  describe 'DELETE destroy' do
  end
end
