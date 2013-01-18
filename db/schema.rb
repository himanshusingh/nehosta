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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130117114618) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "booking_requests", :force => true do |t|
    t.integer  "space_id"
    t.integer  "guest_id"
    t.integer  "host_id"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "amount"
    t.float    "fees"
    t.float    "rent"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "booking_requests", ["guest_id", "space_id"], :name => "index_booking_requests_on_guest_id_and_space_id", :unique => true
  add_index "booking_requests", ["guest_id"], :name => "index_booking_requests_on_guest_id"
  add_index "booking_requests", ["host_id"], :name => "index_booking_requests_on_host_id"
  add_index "booking_requests", ["space_id"], :name => "index_booking_requests_on_space_id"
  add_index "booking_requests", ["start_date", "end_date"], :name => "index_booking_requests_on_start_date_and_end_date"

  create_table "bookings", :force => true do |t|
    t.integer  "space_id"
    t.integer  "guest_id"
    t.integer  "host_id"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "amount"
    t.float    "fees"
    t.float    "rent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bookings", ["guest_id", "space_id"], :name => "index_bookings_on_guest_id_and_space_id", :unique => true
  add_index "bookings", ["guest_id"], :name => "index_bookings_on_guest_id"
  add_index "bookings", ["host_id"], :name => "index_bookings_on_host_id"
  add_index "bookings", ["space_id"], :name => "index_bookings_on_space_id"
  add_index "bookings", ["start_date", "end_date"], :name => "index_bookings_on_start_date_and_end_date"

  create_table "photos", :force => true do |t|
    t.string   "caption",              :default => ""
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "space_id"
  end

  create_table "spaces", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.text     "rules"
    t.string   "street_address"
    t.string   "locality"
    t.string   "city"
    t.string   "country"
    t.integer  "pincode"
    t.integer  "capacity"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.float    "price"
    t.string   "room_type"
    t.string   "amenities"
    t.float    "size"
    t.text     "directions"
    t.integer  "phone_number"
    t.text     "full_address"
  end

  add_index "spaces", ["city"], :name => "index_spaces_on_city"
  add_index "spaces", ["user_id"], :name => "index_spaces_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.string   "location"
    t.date     "birthday"
    t.string   "sex"
    t.string   "provider"
    t.string   "uid"
    t.string   "fb_url"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
