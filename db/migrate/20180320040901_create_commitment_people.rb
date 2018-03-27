class CreateCommitmentPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :commitment_people do |t|
      t.integer :commitment_id
      t.integer :person_id

      t.timestamps
    end
  end
end
