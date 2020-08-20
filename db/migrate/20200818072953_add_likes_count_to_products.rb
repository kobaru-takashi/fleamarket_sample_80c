class AddLikesCountToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :likes_count, :integer
  end
end
