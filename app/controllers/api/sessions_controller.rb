module API
  class SessionsController < ApplicationController
    skip_before_filter :authenticate!, only: :create

    def create
      user = User.find_by_email(session_params[:email])

      unless user.try :authenticate?, params[:session][:password]
        return render json: '', status: :not_found
      end

      @key = user.keys.create name:
        "Login from external app `#{request.headers['Origin']}'"
    end

  private

    def session_params
      params.require(:session).permit %i[email password]
    end
  end
end
