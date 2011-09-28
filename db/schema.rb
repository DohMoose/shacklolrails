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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110927115023) do

  create_table "analyses", :force => true do |t|
    t.integer  "link_id"
    t.integer  "last_lol_id"
    t.integer  "lol_type_id"
    t.integer  "total"
    t.text     "lold_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.integer  "post_id"
    t.integer  "original_post_id"
    t.integer  "user_id"
    t.datetime "date"
    t.text     "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lol_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lols", :force => true do |t|
    t.integer  "user_id"
    t.integer  "link_id"
    t.integer  "lol_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "shackname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
