class Api::SessionsController < Api::ApplicationController
  skip_before_filter :authenticate!, :only => [:create]

  def create
    user = User.find_by_email(params[:session][:email])

    if ! user.try(:authenticate?, params[:session][:password])
      return render :json => '', :status => :not_found
    end

    @user = user
    self.current_user = @user
  end
end
