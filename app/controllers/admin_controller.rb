class AdminController < ApplicationController
  before_action :confirm_authorization

  def index
    @total_orders = Order.count
    @user_name && @user_name = User.find(session[:user_id]).name
  end

end
