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

  create_table "users", :force => true do |t|
    t.string   "shackname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["shackname"], :name => "index_users_on_shackname", :unique => true, :case_sensitive => false
  end

  create_table "links", :force => true do |t|
    t.integer  "post_id"
    t.integer  "article_id"
    t.integer  "original_post_id"
    t.integer  "user_id"
    t.string   "moderation"
    t.datetime "date"
    t.text     "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["article_id"], :name => "index_links_on_article_id"
    t.index ["date"], :name => "index_links_on_date"
    t.index ["original_post_id"], :name => "index_links_on_original_post_id"
    t.index ["post_id"], :name => "index_links_on_post_id"
    t.index ["user_id"], :name => "index_links_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "links_user_id_fkey"
  end

  create_table "lol_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analyses", :force => true do |t|
    t.integer  "link_id"
    t.integer  "last_lol_id"
    t.integer  "lol_type_id"
    t.integer  "total"
    t.text     "lold_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["link_id"], :name => "index_analyses_on_link_id"
    t.index ["lol_type_id"], :name => "index_analyses_on_lol_type_id"
    t.foreign_key ["link_id"], "links", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "analyses_link_id_fkey"
    t.foreign_key ["lol_type_id"], "lol_types", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "analyses_lol_type_id_fkey"
  end

  create_table "lols", :force => true do |t|
    t.integer  "user_id"
    t.integer  "link_id"
    t.integer  "lol_type_id"
    t.string   "version"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["link_id"], :name => "index_lols_on_link_id"
    t.index ["lol_type_id"], :name => "index_lols_on_lol_type_id"
    t.index ["user_id"], :name => "index_lols_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "lols_user_id_fkey"
    t.foreign_key ["link_id"], "links", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "lols_link_id_fkey"
    t.foreign_key ["lol_type_id"], "lol_types", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "lols_lol_type_id_fkey"
  end

end
