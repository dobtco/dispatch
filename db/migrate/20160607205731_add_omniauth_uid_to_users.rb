class AddOmniauthUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_uid, :string
  end
end
