class ChangeConstrainsOnProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :title, false
    change_column_null :products, :description, false
    change_column_null :products, :image_url, false
  end
end
