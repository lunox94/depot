require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
    login_as users(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success

    assert_select "tbody tr", 3
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should show validation errors on new product" do
    post products_url, params: {
      product: Product.new.attributes
    }

    assert_response :unprocessable_entity
    assert_select "div#error_explanation"
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: {
        product: {
          description: @product.description,
          image: file_fixture_upload("lorem.jpg", "image/jpeg"),
          price: @product.price,
          title: @title
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        description: @product.description,
        image: file_fixture_upload("lorem.jpg", "image/jpeg"),
        price: @product.price,
        title: @title
      }
    }
    assert_redirected_to product_url(@product)
  end

  test "should show validation errors on update product" do
    patch product_url(@product), params: {
      product: Product.new.attributes
    }

    assert_response :unprocessable_entity
    assert_select "div#error_explanation"
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should not destroy product" do
    assert_raise ActiveRecord::RecordNotDestroyed do
      delete product_url(products(:two))
    end

    assert Product.exists?(products(:two).id)
  end

  test "should redirect to login page if not signed in" do
    logout

    get products_url

    assert_redirected_to new_session_url
  end
end
