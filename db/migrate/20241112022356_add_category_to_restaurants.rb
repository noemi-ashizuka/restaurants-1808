class AddCategoryToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :category, :string
  end
end
