require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'responds successfully' do
      response.should be_success
    end
  end

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }

    def do_create
      post :create, session: {
        email:    user.email,
        password: user.password
      }
    end

    context 'with valid credentials' do
      it 'signs the user in' do
        do_create
        controller.current_user.should == user
      end

      it 'redirects to the home page' do
        do_create
        response.should redirect_to(:root)
      end
    end

    [:email, :password].each do |attr|
      context "with invalid credentials (#{attr})" do
        before do
          user.stub(attr => user.send(attr) + '_INVALID')
        end

        it 'renders the new template' do
          do_create
          response.should render_template('new')
        end
      end
    end
  end

  describe 'DELETE destroy' do
  end
end
