class SessionsController < ApplicationController
  skip_before_filter :authenticate!, only: %i[new create]

  def create
    user = User.find_by_email(params[:session][:email])

    if user.try :authenticate?, params[:session][:password]
      self.current_user = user
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to :root
  end
end
