require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  test "we create a SupportRequest when we receive mail" do
    receive_inbound_email_from_mail \
      to: "support@example.com",
      from: "customer@example.com",
      subject: "I need help",
      body: "I can't find my order"

    support_request = SupportRequest.last

    assert_equal "customer@example.com", support_request.email
    assert_equal "I need help", support_request.subject
    assert_equal "I can't find my order", support_request.message
    assert_nil support_request.order
  end

  test "we create a SupportRequest with the most recent order" do
    recent_order = orders(:david_second_order)

    receive_inbound_email_from_mail \
      to: "support@example.com",
      from: recent_order.email,
      subject: "I need help",
      body: "I can't find my order"

    support_request = SupportRequest.last

    assert_equal recent_order.email, support_request.email
    assert_equal "I need help", support_request.subject
    assert_equal "I can't find my order", support_request.message
    assert_equal recent_order, support_request.order
  end
end
