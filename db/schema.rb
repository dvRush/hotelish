# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_24_151648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodation_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "accommodations_count", default: 0
    t.index ["name"], name: "index_accommodation_types_on_name"
  end

  create_table "accommodations", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "available", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "daily_value"
    t.bigint "accommodation_type_id"
    t.integer "reservations_count", default: 0
    t.index ["accommodation_type_id"], name: "index_accommodations_on_accommodation_type_id"
    t.index ["deleted_at"], name: "index_accommodations_on_deleted_at"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "zip_code"
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "complement"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_admin_users_on_deleted_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "contact_sources", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reservations_count", default: 0
    t.integer "customers_count", default: 0
    t.index ["name"], name: "index_contact_sources_on_name"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "document"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.date "birthdate"
    t.string "occupation"
    t.bigint "contact_source_id"
    t.integer "reservations_count", default: 0
    t.string "rg"
    t.string "rg_emitter"
    t.index ["contact_source_id"], name: "index_customers_on_contact_source_id"
    t.index ["deleted_at"], name: "index_customers_on_deleted_at"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reservations_count", default: 0
    t.index ["name"], name: "index_payment_methods_on_name"
  end

  create_table "reservation_reasons", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.integer "reservations_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "accommodation_id", null: false
    t.datetime "check_in"
    t.datetime "check_out"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.integer "num_guests"
    t.datetime "deleted_at"
    t.bigint "contact_source_id"
    t.bigint "payment_method_id"
    t.string "reason"
    t.bigint "reason_id"
    t.index ["accommodation_id"], name: "index_reservations_on_accommodation_id"
    t.index ["author_id"], name: "index_reservations_on_author_id"
    t.index ["contact_source_id"], name: "index_reservations_on_contact_source_id"
    t.index ["customer_id"], name: "index_reservations_on_customer_id"
    t.index ["deleted_at"], name: "index_reservations_on_deleted_at"
    t.index ["payment_method_id"], name: "index_reservations_on_payment_method_id"
    t.index ["reason_id"], name: "index_reservations_on_reason_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.json "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
