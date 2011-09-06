class UsersController < ApplicationController
  skip_before_filter :authenticate!, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if ! @user.save
      render :new
    else
      self.current_user =  @user
      redirect_to :root
    end
  end
end
