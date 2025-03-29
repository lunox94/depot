require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_as users(:one)
  end

  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select "nav a", minimum: 4
    assert_select "main ul li", 3
    assert_select "h2", "The Pragmatic Programmer"
    assert_select "div", /\$[,\d]+\.\d\d/
  end

  test "should display date and time" do
    travel_to Time.new(2025, 3, 4, 14, 30, 0) do
      get store_index_url
      assert_select "nav li", I18n.l(Time.current, format: :short)
    end
  end
end
