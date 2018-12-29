require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  test "adding first item to cart reveals cart" do

    visit store_index_url
    assert_no_selector "#cart > article > h2"

    first('.catalog li').click_on 'Add to Cart'
    assert_selector "#cart > article > h2"
  end

  test "Empty Cart button hides cart" do

    visit store_index_url
    first('.catalog li').click_on 'Add to Cart'

    accept_alert do
      click_on 'Empty Cart'
    end

    assert_no_selector "#cart > article > h2"
  end

  test "Cart additions initiate highlighting on relevant item" do

    visit store_index_url
    first('.catalog li').click_on 'Add to Cart'
    assert_selector '#cart tbody tr:first-child.changed-item-highlight'

    find('.catalog li:last-child').click_on 'Add to Cart'
    assert_no_selector '#cart tbody tr:first-child.changed-item-highlight'
    assert_selector '#cart tbody tr:last-child.changed-item-highlight'
  end
end
