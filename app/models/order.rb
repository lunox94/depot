require "pago"

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum :pay_type, {
    "Check"           => 0,
    "Credit card"     => 1,
    "Purchase order"  => 2
  }

  validates :address, :email, :name, presence: true
  validates :pay_type, inclusion: pay_types.keys

  validates :credit_card_number, :expiration_date, presence: true, if: -> { pay_type == "Credit card" }
  validates :routing_number, :account_number, presence: true, if: -> { pay_type == "Check" }
  validates :po_number, presence: true, if: -> { pay_type == "Purchase order" }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |li|
      li.cart_id = nil
      line_items << li
    end
  end

  def charge!
    payment_details = {}
    payment_method = nil

    case pay_type
    when "Check"
      payment_method = :check
      payment_details[:routing] = routing_number
      payment_details[:account] = account_number
    when "Credit card"
      payment_method = :credit_card
      payment_details[:cc_num] = credit_card_number
      payment_details[:expiration_month] = expiration_date.month
      payment_details[:expiration_year] = expiration_date.year
    when "Purchase order"
      payment_method = :po
      payment_details[:po_num] = po_number
    end

    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end
end
