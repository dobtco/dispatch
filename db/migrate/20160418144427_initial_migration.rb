class InitialMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.text :admin_roles, array: true, default: []

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true

    create_table :vendors do |t|
      t.string :name
      t.text :data
      t.timestamps null: false
    end

    create_table :users_vendors, id: false do |t|
      t.references :user, null: false
      t.references :vendor, null: false
    end

    create_table :departments do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :opportunities do |t|
      t.integer :created_by_user_id
      t.string :title
      t.text :description
      t.references :department, index: true, foreign_key: true
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :submission_method
      t.text :submission_method_data

      t.datetime :publish_at
      t.datetime :submissions_open_at
      t.datetime :submissions_close_at

      t.boolean :enable_questions, null: false, default: false
      t.datetime :questions_open_at
      t.datetime :questions_close_at

      t.datetime :approved_at
      t.integer :approved_by_user_id

      t.timestamps null: false
    end

    add_foreign_key :opportunities, :users, column: :created_by_user_id
    add_foreign_key :opportunities, :users, column: :approved_by_user_id

    create_table :attachments do |t|
      t.references :opportunity, index: true, foreign_key: true
      t.string :upload
      t.string :content_type
      t.integer :file_size_bytes
      t.boolean :has_thumbnail, null: false, default: false
      t.timestamps null: false
    end

    create_table :questions do |t|
      t.references :opportunity, index: true, foreign_key: true
      t.integer :asked_by_user_id
      t.integer :answered_by_user_id
      t.text :question_text
      t.text :answer_text
      t.datetime :answered_at
      t.timestamps null: false
    end

    add_foreign_key :questions, :users, column: :asked_by_user_id
    add_foreign_key :questions, :users, column: :answered_by_user_id

    create_table :categories do |t|
      t.string :name
      t.string :group_name
      t.timestamps null: false
    end

    create_table :categories_opportunities, id: false do |t|
      t.references :category, null: false
      t.references :opportunity, null: false
    end

    create_table :categories_users, id: false do |t|
      t.references :category, null: false
      t.references :user, null: false
    end

    create_table :opportunities_users, id: false do |t|
      t.references :opportunity, null: false
      t.references :user, null: false
    end
  end
end
