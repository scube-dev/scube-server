class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def create
    user = User.find_by_email(session_params[:email])

    unless user.try :authenticate?, params[:session][:password]
      return render json: '', status: :not_found
    end

    @key = user.keys.create name: key_name_for_current_request
  end

private

  def session_params
    params.require(:session).permit %i[email password]
  end

  def key_name_for_current_request
    if request.headers.key? 'Origin'
      "Login from external www app `#{request.headers['Origin']}'"
    else
      'Login from external client'
    end
  end
end
