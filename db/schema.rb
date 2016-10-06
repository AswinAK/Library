# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160925192155) do

  create_table "admins", force: true do |t|
    t.string "email_id",        null: false
    t.string "first_name",      null: false
    t.string "last_name",       null: false
    t.string "gender",          null: false
    t.date   "dob",             null: false
    t.string "password_digest"
  end

  create_table "bookings", force: true do |t|
    t.string   "email_id",    null: false
    t.string   "room_number", null: false
    t.integer  "slot"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
<<<<<<< HEAD
    t.string   "email_id",                        null: false
    t.string   "first_name",                      null: false
    t.string   "last_name",                       null: false
    t.string   "gender",                          null: false
    t.date     "dob",                             null: false
    t.boolean  "permitted",       default: false, null: false
=======
    t.string   "email_id",        null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "gender",          null: false
    t.date     "dob",             null: false
>>>>>>> 95176b37bb5de5ee7b5dbd04d95dd5211052b538
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "room_number", null: false
    t.string   "building",    null: false
    t.string   "size",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
