class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :user_name
      t.string :password
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :profile_picture

      t.timestamps
    end
  end
end
