class StoreController < ApplicationController
  include Counter

  before_action :increment_counter, only: %i[ index ]

  def index
    @products = Product.order(:title)
  end
end
