class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.charge!
  end
end
