class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email,              default: nil
      t.string :password_digest, default: nil

      t.timestamps
    end

    add_index :users, :email,                unique: true
  end
end