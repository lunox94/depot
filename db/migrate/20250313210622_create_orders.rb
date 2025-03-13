class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.integer :pay_type
      t.string :email

      t.timestamps
    end
  end
end
