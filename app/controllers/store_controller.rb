class StoreController < ApplicationController
  include Counter
  include CurrentCart

  allow_unauthenticated_access

  before_action :increment_counter, only: %i[ index ]
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
