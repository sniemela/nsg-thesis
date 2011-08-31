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

ActiveRecord::Schema.define(:version => 20110813132235) do

  create_table "advertises", :force => true do |t|
    t.integer  "client_id",                     :null => false
    t.string   "resource_url"
    t.decimal  "price",        :default => 0.0
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer "event_id",    :null => false
    t.integer "category_id", :null => false
  end

  create_table "client_types", :force => true do |t|
    t.string "name"
  end

  create_table "clients", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "client_type_id", :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name",                             :null => false
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "active_time_start"
    t.datetime "active_time_end"
    t.string   "city"
    t.string   "country",                          :null => false
    t.string   "address"
    t.integer  "times_watched",     :default => 0
    t.integer  "submitter_id"
    t.string   "submitter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
