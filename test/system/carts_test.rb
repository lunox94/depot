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

  test "yellow fade technique for line items works" do
    visit store_index_url

    assert has_no_css? ".line-item-highlight"

    click_on "Add to Cart", match: :first

    assert has_css? ".line-item-highlight"
  end
end
