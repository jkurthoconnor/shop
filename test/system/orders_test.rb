require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "check order form displays" do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Some Guy'
    fill_in 'order_address', with: '12345 Big Court'
    fill_in 'order_email', with: 'mrguy@service.com'

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"
    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_po_number"

    select 'Check', from: 'pay_type'

    assert_selector "#order_routing_number"
  end

  test "purchase order form displays" do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Some Guy'
    fill_in 'order_address', with: '12345 Big Court'
    fill_in 'order_email', with: 'mrguy@service.com'

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"
    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_po_number"

    select 'Purchase Order', from: 'pay_type'

    assert_selector "#order_po_number"
  end

  test "credit card number form displays" do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Some Guy'
    fill_in 'order_address', with: '12345 Big Court'
    fill_in 'order_email', with: 'mrguy@service.com'

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"
    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_po_number"

    select 'Credit Card', from: 'pay_type'

    assert_selector "#order_credit_card_number"
    assert_selector "#order_expiration_date"
  end

  test "payment is processed when credit card order form submitted" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    find('.catalog li:first-child').click_on 'Add to Cart'
    click_on 'Checkout'

    fill_in 'order_name', with: 'Some Guy'
    fill_in 'order_address', with: '12345 Big Court'
    fill_in 'order_email', with: 'mrguy@service.com'
    select('Credit Card', from: 'pay_type')
    fill_in 'order_credit_card_number', with: '1234123412341234'
    fill_in 'order_expiration_date', with: '04/21'

    perform_enqueued_jobs do
      click_on 'Place Order'
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first
    assert_equal 'Some Guy', order.name
    assert_equal '12345 Big Court', order.address
    assert_equal 'mrguy@service.com', order.email
    assert_equal 'Credit card', order.pay_type
    assert_equal 1, order.line_items.size
  end
end
