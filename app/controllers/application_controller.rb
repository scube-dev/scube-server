class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate!

  helper_method :current_user?

  def current_user= user
    session[:user_id] = user.id
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user?
    !!current_user
  end


  protected

  def authenticate!
    redirect_to new_session_path if current_user.nil?
  end
end
