class StoreController < ApplicationController
  include Counter
  include CurrentCart

  skip_before_action :confirm_authorization
  before_action :increment_counter, only: [:index]
  before_action :set_cart, only: [:index]

  def index
    @products = Product.order(:title)
  end
end
