class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate!

  helper_method :current_user?

  attr_accessor :current_user

  def current_user?
    !!current_user
  end


  protected

  def authenticate!
    if session[:user_id]
      self.current_user = User.find_by(id: session[:user_id])
    end
    redirect_to new_session_path if current_user.nil?
  end

  def set_session_user user
    session[:user_id] = user.id
  end
end
