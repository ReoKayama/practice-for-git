class AddColumnsToLecture < ActiveRecord::Migration[5.1]
  def change
    add_column :lectures, :t_quarter, :int
    add_column :lectures, :t_day, :text
    add_column :lectures, :t_period, :int
  end
end
