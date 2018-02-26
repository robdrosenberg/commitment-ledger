class ChangeWhenToDue < ActiveRecord::Migration[5.1]
  def change
    rename_column :commitments, :when, :due
  end
end
