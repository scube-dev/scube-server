module UserControllerHelpers
  def sign_in
    controller.current_user = Factory.create(:user)
  end
end
