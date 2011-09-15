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

ActiveRecord::Schema.define(:version => 20110915085309) do

  create_table "ads", :force => true do |t|
    t.integer  "client_id",                           :null => false
    t.decimal  "price",              :default => 0.0
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",               :null => false
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer "event_id",    :null => false
    t.integer "category_id", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name",                           :null => false
    t.integer  "client_type",                    :null => false
    t.text     "description"
    t.string   "address"
    t.string   "country"
    t.boolean  "confirmed",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name",                                 :null => false
    t.text     "description"
    t.datetime "active_time_start"
    t.datetime "active_time_end"
    t.string   "city"
    t.string   "country",                              :null => false
    t.string   "address"
    t.integer  "times_watched",     :default => 0
    t.integer  "liked_count",       :default => 0
    t.boolean  "approved",          :default => false
    t.integer  "submitter_id"
    t.string   "submitter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showtimes", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "event_id"
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

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "client_id"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

end
