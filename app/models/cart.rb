class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    line_item = line_items.find_by(product_id: product.id)

    if line_item
      line_item.quantity += 1
    else
      line_item = line_items.build(product_id: product.id)
      line_item.price = product.price
    end

    line_item
  end

  def total_price
    line_items.sum { |li| li.total_price }
  end
end
