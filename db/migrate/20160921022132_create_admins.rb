class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string "email_id",null: false ,primary_key: true
      t.string "name", null: false
      t.string "password_digest"
      t.timestamps
    end
  end
end
