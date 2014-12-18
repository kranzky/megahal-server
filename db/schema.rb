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

ActiveRecord::Schema.define(version: 20141218231917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.string   "user",       null: false
    t.string   "key",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "job_id"
  end

  add_index "chats", ["job_id"], name: "index_chats_on_job_id", using: :btree
  add_index "chats", ["key"], name: "index_chats_on_key", unique: true, using: :btree

  create_table "jobs", force: true do |t|
    t.integer  "utterance_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "jobs", ["utterance_id"], name: "index_jobs_on_utterance_id", using: :btree

  create_table "utterances", force: true do |t|
    t.integer  "chat_id"
    t.string   "type",       null: false
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "utterances", ["chat_id"], name: "index_utterances_on_chat_id", using: :btree

  add_foreign_key "chats", "jobs"
  add_foreign_key "jobs", "utterances"
  add_foreign_key "utterances", "chats"
end
