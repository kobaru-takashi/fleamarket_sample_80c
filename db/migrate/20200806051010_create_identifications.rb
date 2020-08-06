class CreateIdentifications < ActiveRecord::Migration[6.0]
  def change
    create_table :identifications do |t|
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana, null: false
      t.datetime :birth, null:false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
