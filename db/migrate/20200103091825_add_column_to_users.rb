class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :grade, :int
    add_column :users, :major, :text 
  end
end
