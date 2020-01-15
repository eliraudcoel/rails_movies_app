class CreateJwtBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :jwt_blacklists do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
    add_index :jwt_blacklists, :jti

    # Add to user table
    add_column :users, :jti, :string
    User.all.each { |user| user.update_column(:jti, SecureRandom.uuid) }
    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end
end
