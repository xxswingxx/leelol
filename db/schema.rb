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

ActiveRecord::Schema.define(:version => 20130629141252) do

  create_table "champions", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "range"
    t.float    "health_base"
    t.float    "health_per_lvl"
    t.float    "health_regen_base"
    t.float    "health_regen_per_lvl"
    t.float    "mana_base"
    t.float    "mana_per_lvl"
    t.float    "mana_regen_base"
    t.float    "mana_regen_per_lvl"
    t.float    "attack_base"
    t.float    "attack_per_lvl"
    t.float    "attack_speed_base"
    t.float    "attack_speed_per_lvl"
    t.float    "armor_base"
    t.float    "armor_per_lvl"
    t.float    "magic_resist_base"
    t.float    "magic_resist_per_level"
    t.float    "movement_speed"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "passive"
    t.integer  "cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.text     "stats"
    t.text     "active"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
