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

ActiveRecord::Schema.define(version: 20150211134058) do

  create_table "estimate_blueprints", force: true do |t|
    t.integer  "type_id"
    t.integer  "me"
    t.integer  "te"
    t.integer  "runs"
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_blueprints", ["estimate_id"], name: "index_estimate_blueprints_on_estimate_id", using: :btree

  create_table "estimate_materials", force: true do |t|
    t.integer  "type_id"
    t.integer  "require_count"
    t.decimal  "price",                  precision: 20, scale: 4
    t.decimal  "total_price",            precision: 20, scale: 4
    t.decimal  "jita_total_price",       precision: 20, scale: 4
    t.decimal  "jita_average_price",     precision: 20, scale: 4
    t.decimal  "universe_total_price",   precision: 20, scale: 4
    t.decimal  "universe_average_price", precision: 20, scale: 4
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_materials", ["estimate_id"], name: "index_estimate_materials_on_estimate_id", using: :btree

  create_table "estimates", force: true do |t|
    t.integer  "type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industry_systems", force: true do |t|
    t.integer  "solar_system_id"
    t.decimal  "cost_index",      precision: 20, scale: 16
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "market_details", force: true do |t|
    t.integer  "volume"
    t.boolean  "buy"
    t.decimal  "price",      precision: 10, scale: 0
    t.integer  "duration"
    t.integer  "station_id"
    t.datetime "issued"
    t.integer  "market_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "market_details", ["market_id"], name: "index_market_details_on_market_id", using: :btree

  create_table "market_prices", force: true do |t|
    t.integer  "type_id"
    t.decimal  "adjusted_price", precision: 20, scale: 4
    t.decimal  "average_price",  precision: 20, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", force: true do |t|
    t.integer  "type_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "expire"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
