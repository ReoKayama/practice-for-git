class AddEvColumnsToLectures < ActiveRecord::Migration[5.1]
  def change
    add_column :lectures, :ev_method, :text
    add_column :lectures, :ev_attendance, :text
    add_column :lectures, :ev_understanding, :float
    add_column :lectures, :ev_score, :float
    add_column :lectures, :ev_interest, :float
    add_column :lectures, :ev_getting, :text
  end
end
