module UserIntegrationHelpers
  def sign_in
    user = FactoryGirl.create(:user)
    visit new_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button('Sign in')
  end

  def api_sign_in
    user = FactoryGirl.create :user

    post api_sessions_path, :format => :json, :session => {
      :email    => user.email,
      :password => user.password
    }
  end
end
