class ApplicationController < ActionController::Base
  before_action :confirm_authorization

  private
  def confirm_authorization
    if !( session[:user_id] && User.find(session[:user_id]))
      redirect_to login_url, notice: "You must be logged in."
    end
  end
end
