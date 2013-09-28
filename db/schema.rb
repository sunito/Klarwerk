# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130928004755) do

  create_table "diagramme", :force => true do |t|
    t.string   "name"
    t.text     "beschreibung"
    t.integer  "zeit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diaquen", :force => true do |t|
    t.integer  "quelle_id"
    t.integer  "diagramm_id"
    t.string   "farbe"
    t.float    "streckungsfaktor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "einheiten", :force => true do |t|
    t.string   "name"
    t.text     "beschreibung"
    t.float    "min"
    t.float    "max"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gequantelt"
  end

  create_table "quellen", :force => true do |t|
    t.string   "adresse"
    t.string   "name"
    t.string   "variablen_art"
    t.text     "beschreibung"
    t.integer  "einheit_id"
    t.string   "farbe"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zeiten", :force => true do |t|
    t.datetime "bis"
    t.integer  "dauer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
