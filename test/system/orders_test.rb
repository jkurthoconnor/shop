require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test "check routing number" do
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

  test "purchase order number" do
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

  test "credit card number" do
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
end
