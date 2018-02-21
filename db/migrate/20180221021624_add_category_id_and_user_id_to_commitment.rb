class AddCategoryIdAndUserIdToCommitment < ActiveRecord::Migration[5.1]
  def change
    add_column :commitments, :user_id, :int
    add_column :commitments, :category_id, :int
  end
end
