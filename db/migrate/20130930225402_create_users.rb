class CreateUsers < ActiveRecord::Migration
  def self.up
    execute "CREATE EXTENSION IF NOT EXISTS hstore"

    create_table :users  do |t|
      t.integer :dobt_user_id
      t.string :global_remember_token
      t.string :local_remember_token
      t.hstore :profile, default: '', null: false
      t.text :organizations
      t.boolean :needs_remote_refresh, default: false

      t.timestamps null: false
    end

    add_index :users, :dobt_user_id
    add_index :users, :global_remember_token
    add_index :users, :local_remember_token
  end

  def self.down
    drop_table :users
  end
end
