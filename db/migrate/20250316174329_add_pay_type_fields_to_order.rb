class AddPayTypeFieldsToOrder < ActiveRecord::Migration[8.0]
  def change
    # credit card fields
    add_column :orders, :credit_card_number, :string, null: true, default: nil
    add_column :orders, :expiration_date, :date, null: true, default: nil

    # check fields
    add_column :orders, :routing_number, :string, null: true, default: nil
    add_column :orders, :account_number, :string, null: true, default: nil

    # purchase order fields
    add_column :orders, :po_number, :integer, null: true, default: nil
  end
end
