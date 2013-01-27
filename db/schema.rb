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

ActiveRecord::Schema.define(:version => 20120718161411) do

  create_table "toilet_ratings", :force => true do |t|
    t.integer  "toilet_id"
    t.integer  "cleanness"
    t.integer  "safety"
    t.integer  "privacy"
    t.integer  "comfort"
    t.boolean  "has_hook"
    t.boolean  "has_tissue"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "toilets", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.boolean  "has_male"
    t.boolean  "has_female"
    t.boolean  "has_both"
    t.boolean  "has_family"
    t.boolean  "has_free_access"
    t.boolean  "gmaps"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
