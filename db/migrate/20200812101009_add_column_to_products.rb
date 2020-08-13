class AddColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :saler_id, :integer
    add_column :products, :buyer_id, :integer
  end
end
