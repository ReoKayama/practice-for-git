class AddColumnToFavv < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :fav_day, :text
    add_column :favorites, :fav_period, :int
  end
end
