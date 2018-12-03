require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes may not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  def new_product(price_val, title_val="This is the default title.")
    Product.new(title: title_val,
                description: "An item description here!",
                image_url: "somefile.jpg",
                price: price_val)
  end

  test "product price must not be negative" do
    negative_prices = [-1.00, -0.01, -100.00, -20.00]

    negative_prices.each do |price|
      assert new_product(price).invalid?
    end
  end

  test "product price must not be zero" do
    product = new_product(0.00)

    assert product.invalid?
    assert_equal ["must be greater than 0.00"],
                  product.errors[:price]
  end

  test "product price accepted equal or greater than 0.01" do
    valid_prices = [0.01, 0.02, 100.00, 12, 192.01]

    valid_prices.each do |price|
        assert new_product(price).valid?
    end
  end

  test "product must not have non-numeric value" do
    non_numeric_prices = %w{one two nineteen zero forty eleven}
    
    non_numeric_prices.each do |price|
      assert new_product(price).invalid?
    end
  end

  test "product title must be unique" do
    product = new_product(0.01, products(:ruby).title)

    assert product.invalid?
    assert_equal ["has already been taken"],
                  product.errors[:title]
  end

  test "product title must not be less than 8 characters" do
    product = new_product(1.00, "short")

    assert product.invalid?
    assert_equal ["is too short (minimum is 8 characters)"],
                  product.errors[:title]
  end


  test "product title must not be more than 100 characters" do
    product = new_product(1.00, ('1'..'101').to_a.join)

    assert product.invalid?
    assert_equal ["is too long (maximum is 100 characters)"],
                  product.errors[:title]
  end

  test "product description must not be less than 20 characters" do
    product = new_product(1.00)
    product.description = "too short"

    assert product.invalid?
    assert_equal ["is too short (minimum is 20 characters)"],
                  product.errors[:description]
  end

  test "product description must not be more than 1000 characters" do
    product = new_product(1.00)
    product.description = ('1'..'1001').to_a.join

    assert product.invalid?
    assert_equal ["is too long (maximum is 1000 characters)"],
                  product.errors[:description]
  end

  test "product image_url must have proper extension" do
    product = new_product(100.01)
    product.image_url = "someotherfile.image"

    assert product.invalid?
    assert_equal ["expected URL for file with an image extension"],
                  product.errors[:image_url]
  end
end
