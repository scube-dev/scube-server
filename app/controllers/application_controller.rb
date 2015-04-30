class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!

  def current_user= user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  protected

  def authenticate!
    redirect_to new_session_path if current_user.nil?
  end
end
