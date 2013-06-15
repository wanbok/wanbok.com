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

ActiveRecord::Schema.define(:version => 20130615175729) do

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.string   "user"
    t.string   "sex"
    t.string   "age"
    t.integer  "q1"
    t.integer  "q2"
    t.integer  "q3"
    t.integer  "q4"
    t.integer  "q5"
    t.integer  "q6"
    t.integer  "q7"
    t.integer  "q8"
    t.integer  "q9"
    t.integer  "q10"
    t.integer  "q11"
    t.integer  "q12"
    t.integer  "q13"
    t.integer  "q14"
    t.integer  "q15"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
