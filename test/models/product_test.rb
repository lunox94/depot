require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @title = "The Great Book #{rand(1000)}"
  end

  test "products attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:price].any?
    assert product.errors[:title].any?
    assert product.errors[:image].any?
    assert product.errors[:description].any?
  end

  test "product price must be possitive" do
    product = Product.new(description: "xyz", title: @title)
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")

    product.price = -1
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    product = Product.new(description: "xyz", price: 1, title: @title)
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")

    assert product.valid?, "image/jpeg must be valid"

    product = Product.new(description: "xyz", price: 1, title: @title)
    product.image.attach(io: File.open("test/fixtures/files/logo.svg"), filename: "logo.svg", content_type: "image/svg+xml")

    assert_not product.valid?, "image/svg+xml must be invalid"
  end

  test "product is not valid without a unique title" do
    product = Product.new(description: "xyz", price: 1, title: products(:pragprog).title)
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")

    assert product.invalid?

    assert [ I18n.translate("errors.messages.taken") ], product.errors[:title]
  end

  test "product title" do
    product = products(:one)
    product.title = "Short"
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")

    assert product.invalid?

    assert_equal [ I18n.translate("errors.messages.too_short", count: 10) ], product.errors[:title]

    product.title = @title

    assert product.valid?
  end
end
