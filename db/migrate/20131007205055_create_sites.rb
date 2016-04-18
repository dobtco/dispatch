class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.hstore :organization_app, default: '', null: false
      t.hstore :organization, default: '', null: false
      t.text :app_plan
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
