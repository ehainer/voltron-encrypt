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

ActiveRecord::Schema.define(version: 20161122173950) do

  create_table "animals", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_animals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_cars", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "phone"
    t.integer  "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voltron_ids", id: false, force: :cascade do |t|
    t.integer "id",            limit: 8
    t.integer "resource_id",   limit: 8
    t.string  "resource_type"
  end

end
