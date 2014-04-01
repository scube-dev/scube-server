module UserControllerHelpers
  def sign_in
    controller.current_user = FactoryGirl.create(:user)
  end
end
