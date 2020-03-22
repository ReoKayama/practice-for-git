class AddColumnToReview2 < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :understanding, :int
    add_column :reviews, :getting,       :int
    add_column :reviews, :interest,      :int
    add_column :reviews, :score,         :int
    add_column :reviews, :tokutan,       :text
    add_column :reviews, :attendance,    :text
    add_column :reviews, :method,        :text
    add_column :reviews, :comment,       :text
  end
end
