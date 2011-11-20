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

ActiveRecord::Schema.define(:version => 20110926072223) do

  create_table "ads", :force => true do |t|
    t.integer  "client_id",                                                            :null => false
    t.decimal  "price",              :precision => 10, :scale => 0, :default => 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.boolean  "confirmed",                                         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["client_id"], :name => "index_ads_on_client_id"
  add_index "ads", ["confirmed"], :name => "index_ads_on_confirmed"
  add_index "ads", ["price"], :name => "index_ads_on_price"

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

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "categorizations", :force => true do |t|
    t.integer "event_id",    :null => false
    t.integer "category_id", :null => false
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["event_id", "category_id"], :name => "index_categorizations_on_event_id_and_category_id"

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

  add_index "clients", ["confirmed"], :name => "index_clients_on_confirmed"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "name",                                    :null => false
    t.text     "description"
    t.datetime "active_time_start"
    t.datetime "active_time_end"
    t.string   "country",                                 :null => false
    t.string   "address"
    t.string   "city"
    t.integer  "times_watched",        :default => 0
    t.integer  "liked_count",          :default => 0
    t.boolean  "approved",             :default => false
    t.integer  "submitter_id"
    t.string   "submitter_type"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["approved"], :name => "index_events_on_approved"
  add_index "events", ["submitter_id", "submitter_type"], :name => "index_events_on_submitter_id_and_submitter_type"

  create_table "galleries", :force => true do |t|
    t.integer  "event_id"
    t.string   "name"
    t.string   "description"
    t.integer  "times_watched"
    t.integer  "liked_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["event_id"], :name => "index_galleries_on_event_id"

  create_table "gallery_resources", :force => true do |t|
    t.integer  "gallery_id"
    t.string   "resource_file_name"
    t.string   "resource_content_type"
    t.integer  "resource_file_size"
    t.datetime "resource_updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "times_watched"
    t.integer  "liked_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gallery_resources", ["gallery_id"], :name => "index_gallery_resources_on_gallery_id"

  create_table "showtimes", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "showtimes", ["event_id"], :name => "index_showtimes_on_event_id"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "client_id"
    t.string   "email"
    t.string   "avatar"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["client_id"], :name => "index_users_on_client_id"

end
