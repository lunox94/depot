require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  test "add to cart makes the cart show" do
    visit store_index_url

    assert_no_selector "#cart"

    click_on "Add to Cart", match: :first

    assert_selector "#cart"
  end

  test "add to cart makes the cart hide" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    assert_selector "#cart"

    click_on "Empty Cart"

    assert_no_selector "#cart"
  end
end
