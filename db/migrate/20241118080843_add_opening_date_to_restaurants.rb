class AddOpeningDateToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :opening_date, :date
  end
end
