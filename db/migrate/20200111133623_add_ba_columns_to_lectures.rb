class AddBaColumnsToLectures < ActiveRecord::Migration[5.1]
  def change
    add_column :lectures, :professor, :text
    add_column :lectures, :lec_name, :text
  end
end
