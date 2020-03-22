class AddEnColumnsToLectures < ActiveRecord::Migration[5.1]
  def change
    add_column :lectures, :group, :text
    add_column :lectures, :en_major, :text
    add_column :lectures, :en_grade, :int
  end
end
