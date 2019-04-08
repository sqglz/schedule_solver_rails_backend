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

ActiveRecord::Schema.define(version: 2019_04_08_161953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_users", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_users_on_business_id"
    t.index ["user_id"], name: "index_business_users_on_user_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responsibilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shift_preferences", force: :cascade do |t|
    t.bigint "shift_id"
    t.bigint "user_id"
    t.integer "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_shift_preferences_on_shift_id"
    t.index ["user_id"], name: "index_shift_preferences_on_user_id"
  end

  create_table "shift_responsibilities", force: :cascade do |t|
    t.bigint "shift_id"
    t.bigint "responsibility_id"
    t.boolean "assigned"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["responsibility_id"], name: "index_shift_responsibilities_on_responsibility_id"
    t.index ["shift_id"], name: "index_shift_responsibilities_on_shift_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "business_id"
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_shifts_on_business_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_role", default: 0
    t.string "username"
    t.datetime "employment_start_date"
    t.string "worker_responsibilities", default: [], array: true
  end

  add_foreign_key "business_users", "businesses"
  add_foreign_key "business_users", "users"
  add_foreign_key "shift_preferences", "shifts"
  add_foreign_key "shift_preferences", "users"
  add_foreign_key "shift_responsibilities", "responsibilities"
  add_foreign_key "shift_responsibilities", "shifts"
  add_foreign_key "shifts", "businesses"
end
