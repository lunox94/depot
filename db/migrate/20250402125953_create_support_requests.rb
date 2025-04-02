class CreateSupportRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :support_requests do |t|
      t.string :email, comment: "Email of the submitter"
      t.string :subject, comment: "Subject of the support request"
      t.text :message, comment: "Message content of the support request"
      t.references :order, foreign_key: true, comment: "Reference to the order associated with the support request"
      t.timestamps
    end
  end
end
