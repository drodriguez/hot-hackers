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

ActiveRecord::Schema.define(:version => 20101105153639) do

  create_table "hackers", :force => true do |t|
    t.string   "username",                      :null => false
    t.string   "gravatar_id"
    t.integer  "ranking",     :default => 1500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hackers", ["ranking"], :name => "index_hackers_on_ranking"
  add_index "hackers", ["username"], :name => "index_hackers_on_username", :unique => true

end
