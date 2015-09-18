class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::ImplicitRender

  before_action :authenticate!

  helper_method :current_user?

  attr_accessor :current_user

  def current_user?
    !!current_user
  end
end
