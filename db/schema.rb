# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_23_195718) do
  create_table "bookings", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "user_id", default: 0, null: false
    t.date "check_in_date"
    t.date "check_out_date"
    t.integer "guests_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "status", default: 0
    t.datetime "check_in_done"
    t.datetime "check_out_done"
    t.float "payment_amount"
    t.string "payment_method"
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "custom_prices", force: :cascade do |t|
    t.date "begin_date"
    t.date "end_date"
    t.integer "price"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_custom_prices_on_room_id"
  end

  create_table "guesthouses", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "state"
    t.string "city"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.text "description"
    t.string "payment_method"
    t.string "pet_agreement"
    t.text "usage_policy"
    t.time "check_in"
    t.time "check_out"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_guesthouses_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "score"
    t.text "review_text"
    t.integer "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "answer"
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "area"
    t.integer "max_guest"
    t.integer "default_price"
    t.boolean "bathroom"
    t.boolean "balcony"
    t.boolean "air_conditioner"
    t.boolean "tv"
    t.boolean "wardrobe"
    t.boolean "safe"
    t.boolean "accessible"
    t.integer "guesthouse_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["guesthouse_id"], name: "index_rooms_on_guesthouse_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cpf"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "custom_prices", "rooms"
  add_foreign_key "guesthouses", "users"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "rooms", "guesthouses"
end
