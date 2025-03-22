class StoreController < ApplicationController
  include Counter
  include CurrentCart

  allow_unauthenticated_access

  before_action :increment_counter, only: %i[ index ]
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end
end
