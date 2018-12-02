require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes may not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  def new_product(price_var)
    Product.new(title: "Title",
                description: "An item",
                image_url: "somefile.jpg",
                price: price_var)
  end

  test "product price must not be negative" do
    negative_prices = [-1.00, -0.01, -100.00, -20.00]

    negative_prices.each do |price_var|
      assert new_product(price_var).invalid?
    end
  end

  test "product price must not be zero" do
    product = Product.new(title: "Title",
                          description: "An item",
                          image_url: "somefile.jpg",
                          price: 0.00)
    assert product.invalid?
    assert_equal ["must be greater than 0.00"],
                  product.errors[:price]
  end

  test "product price accepted equal or greater than 0.01" do
    valid_prices = [0.01, 0.02, 100.00, 12, 192.01]

    valid_prices.each do |price_var|
        assert new_product(price_var).valid?
    end
  end

  test "product must not have non-numeric value" do
    non_numeric_prices = %w{one two nineteen zero forty eleven}
    
    non_numeric_prices.each do |price_var|
      assert new_product(price_var).invalid?
    end
  end

  # NEED TO USE FIXTURES TO TEST UNIQUENESS
  # test "product title must be unique" do
  #   product1 = Product.new(title: "Title",
  #                         description: "An item",
  #                         image_url: "somefile.jpg",
  #                         price: 0.01)
  #   product2 = Product.new(title: "Title",
  #                         description: "An item, really not the first",
  #                         image_url: "someotherfile.jpg",
  #                         price: 100.01)

  #   assert product1.valid?
  #   assert product2.invalid?
  #   # assert_equal ["has already been taken"],
  #                 # product2.errors[:title]
  # end

  test "product image_url must have proper extension" do
    product = Product.new(title: "Title",
                          description: "An item, really not the first",
                          image_url: "someotherfile.image",
                          price: 100.01)

    assert product.invalid?
    assert_equal ["expected URL for file with an image extension"],
                  product.errors[:image_url]
  end
end
