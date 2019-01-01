class SessionsController < ApplicationController
  skip_before_action :confirm_authorization

  def new
    if !User.first
      redirect_to new_user_path
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid credentials."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: 'You have logged out.'
  end
end
