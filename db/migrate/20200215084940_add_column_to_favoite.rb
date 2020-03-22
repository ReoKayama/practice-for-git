class AddColumnToFavoite < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :lec_id, :int
  end
end
