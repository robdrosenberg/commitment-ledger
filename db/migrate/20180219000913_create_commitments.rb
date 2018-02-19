class CreateCommitments < ActiveRecord::Migration[5.1]
  def change
    create_table :commitments do |t|
      t.string :what
      t.string :who
      t.datetime :when
      t.string :status
      t.text :notes

      t.timestamps
    end
  end
end
