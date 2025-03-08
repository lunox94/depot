require "test_helper"

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.new
  end

  test "add a single product to the cart" do
    one = products(:one)
    pragprog = products(:pragprog)

    @cart.add_product(one).save!
    @cart.add_product(pragprog).save!

    assert_equal @cart.line_items.count, 2
    assert_equal @cart.total_price, one.price + pragprog.price
  end

  test "add multiple products to the cart" do
    one = products(:one)
    pragprog = products(:pragprog)

    @cart.add_product(one).save!

    3.times do
      @cart.add_product(pragprog).save!
    end

    assert_equal @cart.line_items.count, 2
    assert_equal @cart.total_price, one.price + pragprog.price * 3
  end
end
