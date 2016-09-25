class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string "email_id", null: false, primary_key: true
      t.string "room_number", null:false, primary_key: true

      ##Add fields for start and end times
      t.timestamps
    end
  end
end
