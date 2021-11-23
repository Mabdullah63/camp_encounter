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

ActiveRecord::Schema.define(version: 2021_11_23_101603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camps", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "camp_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "camps_locations", id: false, force: :cascade do |t|
    t.bigint "camp_id", null: false
    t.bigint "location_id", null: false
    t.index ["camp_id", "location_id"], name: "index_camps_locations_on_camp_id_and_location_id"
    t.index ["location_id", "camp_id"], name: "index_camps_locations_on_location_id_and_camp_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_applications", force: :cascade do |t|
    t.bigint "camp_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "age"
    t.string "gender"
    t.boolean "lunch"
    t.string "insurance"
    t.string "food_options"
    t.string "Dinner"
    t.string "medical_history"
    t.boolean "wifi_service"
    t.string "address"
    t.string "emergency_contact"
    t.string "shirt_size"
    t.integer "progress_bar"
    t.index ["camp_id"], name: "index_user_applications_on_camp_id"
    t.index ["user_id"], name: "index_user_applications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "phone", null: false
    t.string "country"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.string "country_code"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_applications", "camps"
  add_foreign_key "user_applications", "users"
end
