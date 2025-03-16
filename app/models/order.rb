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
end
