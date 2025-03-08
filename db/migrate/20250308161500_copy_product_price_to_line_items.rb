class CopyProductPriceToLineItems < ActiveRecord::Migration[8.0]
  def up
    LineItem.where("price=0").each do |li|
      li.price = li.product.price
      li.save!
    end
  end

  def down
    LineItem.all.each do |li|
      li.price = 0
      li.save!
    end
  end
end
