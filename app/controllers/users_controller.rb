class UsersController < ApplicationController
  skip_before_filter :authenticate!, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if !@user.save
      render :new
    else
      self.set_session_user @user
      redirect_to :root
    end
  end

private

  def user_params
    params.require(:user).permit %i[email password password_confirmation]
  end
end
