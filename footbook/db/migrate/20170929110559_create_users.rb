class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :account
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :account, unique: true
  end
end
