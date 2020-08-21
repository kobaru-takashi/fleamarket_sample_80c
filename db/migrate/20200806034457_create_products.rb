class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :content, null:false
      t.integer :condition, null:false
      t.integer :delivery_fee, null:false
      t.integer :send_from, null:false
      t.integer :delivery_date, null:false
      t.string :brand, null:false
      t.references :user
      t.references :category
      t.timestamps
    end
  end
end
