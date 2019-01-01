class AdminController < ApplicationController
  before_action :confirm_authorization

  def index
    @total_orders = Order.count
    session[:user_id] && @user_name = User.find(session[:user_id]).name
  end
end
