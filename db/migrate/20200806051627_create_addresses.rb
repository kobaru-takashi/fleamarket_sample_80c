class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :family_name, null:false
      t.string :first_name, null:false
      t.string :family_name_kana, null:false
      t.string :first_name_kana, null: false
      t.integer :post_code, null: false
      t.integer :prefecture, null: false, default: 0
      t.string :city, null: false
      t.string :address, null: false
      t.string :building
      t.integer :telephone_number
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
