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

ActiveRecord::Schema.define(version: 20141229165940) do

  create_table "genres", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photographies", force: true do |t|
    t.string   "image",      null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photography_genres", force: true do |t|
    t.integer  "genre_id",       null: false
    t.integer  "photography_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photography_genres", ["photography_id"], name: "index_photography_genres_on_photography_id", using: :btree

  create_table "points", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "value",          default: 0, null: false
    t.integer  "photography_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "points", ["photography_id"], name: "index_points_on_photography_id", using: :btree
  add_index "points", ["user_id", "photography_id"], name: "index_points_on_user_id_and_photography_id", unique: true, using: :btree

  create_table "system_configs", force: true do |t|
    t.string   "twitter_consumer_key"
    t.string   "twitter_consumer_secret"
    t.string   "facebook_api_key"
    t.string   "facebook_api_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_genre_rankings", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "genre_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "sns_id"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_access_token"
    t.string   "oauth_access_token_secret"
  end

  add_index "users", ["sns_id", "provider"], name: "index_users_on_sns_id_and_provider", unique: true, using: :btree

end
