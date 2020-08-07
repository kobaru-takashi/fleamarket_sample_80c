class CreateProductCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_categories do |t|
      t.references :product, null:false
      t.references :category, null:false
      t.timestamps
    end
  end
end
