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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_25_001209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "gender"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "referral_code"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "referrer_id"
    t.text "name_ciphertext"
    t.text "email_ciphertext"
    t.text "cpf_ciphertext"
    t.text "birth_date_ciphertext"
    t.string "cpf_bidx"
    t.index ["cpf_bidx"], name: "index_accounts_on_cpf_bidx", unique: true
    t.index ["referral_code"], name: "index_accounts_on_referral_code", unique: true
    t.index ["referrer_id"], name: "index_accounts_on_referrer_id"
  end

  add_foreign_key "accounts", "accounts", column: "referrer_id"
end
