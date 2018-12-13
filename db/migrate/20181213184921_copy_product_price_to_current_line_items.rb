class CopyProductPriceToCurrentLineItems < ActiveRecord::Migration[5.2]
  def up
    LineItem.all.each do |item|
      product_price = Product.find(item.product_id).price
      item.price = product_price
    end
  end
end
