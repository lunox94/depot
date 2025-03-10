class CombineItemsInCart < ActiveRecord::Migration[8.0]
  def up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all

          li = cart.line_items.build(product_id: product_id)
          li.quantity = quantity
          li.save!
        end
      end
    end
  end

  def down
    LineItem.where("quantity>1").each do |li|
      li.quantity.times do
        LineItem.create(
          cart_id: li.cart_id,
          product_id: li.product_id,
          quantity: 1
        )
      end

      li.destroy
    end
  end
end
