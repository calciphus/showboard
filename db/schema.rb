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

ActiveRecord::Schema.define(version: 20150206002806) do

  create_table "interactions", force: true do |t|
    t.string   "ds_id"
    t.text     "content"
    t.string   "author_id"
    t.string   "author_name"
    t.boolean  "has_photo"
    t.string   "source_type"
    t.boolean  "body_match"
    t.boolean  "link_match"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.string   "varval"
    t.string   "vartype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
