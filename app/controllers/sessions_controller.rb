class SessionsController < ApplicationController
  skip_before_filter :authenticate!, :only => [:new, :create]

  def create
    user = User.authenticate(
      params[:session][:email],
      params[:session][:password]
    )
    if ! user
      render 'new'
    else
      self.current_user = user
      redirect_to :root
    end
  end
end
