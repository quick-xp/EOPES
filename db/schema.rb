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

ActiveRecord::Schema.define(version: 20150411083641) do

  create_table "estimate_blueprints", force: :cascade do |t|
    t.integer  "type_id",     limit: 4
    t.integer  "me",          limit: 4
    t.integer  "te",          limit: 4
    t.integer  "runs",        limit: 4
    t.integer  "estimate_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_blueprints", ["estimate_id"], name: "index_estimate_blueprints_on_estimate_id", using: :btree

  create_table "estimate_job_costs", force: :cascade do |t|
    t.integer  "region_id",         limit: 4
    t.integer  "solar_system_id",   limit: 4
    t.decimal  "system_cost_index",           precision: 20, scale: 16
    t.decimal  "base_job_cost",               precision: 20, scale: 4
    t.decimal  "job_fee",                     precision: 20, scale: 4
    t.decimal  "facility_cost",               precision: 20, scale: 4
    t.decimal  "total_job_cost",              precision: 20, scale: 4
    t.integer  "estimate_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_job_costs", ["estimate_id"], name: "index_estimate_job_costs_on_estimate_id", using: :btree

  create_table "estimate_materials", force: :cascade do |t|
    t.integer  "type_id",                limit: 4
    t.integer  "require_count",          limit: 4
    t.integer  "base_quantity",          limit: 4
    t.decimal  "price",                            precision: 20, scale: 4
    t.decimal  "adjusted_price",                   precision: 20, scale: 4
    t.decimal  "total_price",                      precision: 20, scale: 4
    t.decimal  "jita_total_price",                 precision: 20, scale: 4
    t.decimal  "jita_average_price",               precision: 20, scale: 4
    t.decimal  "universe_total_price",             precision: 20, scale: 4
    t.decimal  "universe_average_price",           precision: 20, scale: 4
    t.decimal  "volume",                           precision: 20, scale: 4
    t.decimal  "total_volume",                     precision: 20, scale: 4
    t.integer  "estimate_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_materials", ["estimate_id"], name: "index_estimate_materials_on_estimate_id", using: :btree

  create_table "estimates", force: :cascade do |t|
    t.integer  "type_id",             limit: 4
    t.integer  "user_id",             limit: 4
    t.decimal  "sell_price",                    precision: 20, scale: 4
    t.integer  "sell_count",          limit: 4
    t.integer  "product_type_id",     limit: 4
    t.decimal  "total_cost",                    precision: 20, scale: 4
    t.decimal  "sell_total_price",              precision: 20, scale: 4
    t.decimal  "material_total_cost",           precision: 20, scale: 4
    t.decimal  "profit",                        precision: 20, scale: 4
    t.decimal  "total_volume",                  precision: 20, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industry_systems", force: :cascade do |t|
    t.integer  "solar_system_id", limit: 4
    t.decimal  "cost_index",                precision: 20, scale: 16
    t.integer  "activity_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "map_jumps", force: :cascade do |t|
    t.integer "from_solar_system_id", limit: 4
    t.integer "to_solar_system_id",   limit: 4
    t.integer "jump",                 limit: 4
  end

  create_table "market_details", force: :cascade do |t|
    t.integer  "volume",     limit: 4
    t.boolean  "buy",        limit: 1
    t.decimal  "price",                precision: 10
    t.integer  "duration",   limit: 4
    t.integer  "station_id", limit: 4
    t.datetime "issued"
    t.integer  "market_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "market_details", ["market_id"], name: "index_market_details_on_market_id", using: :btree

  create_table "market_prices", force: :cascade do |t|
    t.integer  "type_id",        limit: 4
    t.decimal  "adjusted_price",           precision: 20, scale: 4
    t.decimal  "average_price",            precision: 20, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", force: :cascade do |t|
    t.integer  "type_id",    limit: 4
    t.integer  "region_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "token",                  limit: 255
    t.string   "refresh_token",          limit: 255
    t.datetime "expire"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
