class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string "email_id", null: false
      t.string "room_number", null:false

      ##Add fields for start and end times
      t.timestamps
    end
  end
end
