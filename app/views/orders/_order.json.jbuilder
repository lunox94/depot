json.extract! order, :id, :name, :address, :pay_type, :email, :created_at, :updated_at
json.url order_url(order, format: :json)
