class SupportMailbox < ApplicationMailbox
  def process
    recent_order = Order.where(email: mail.from_address.to_s).order("created_at desc").first

    SupportRequest.create!(
      email: mail.from_address.to_s,
      message: mail.body.to_s,
      order: recent_order,
      subject: mail.subject
    )
  end
end
