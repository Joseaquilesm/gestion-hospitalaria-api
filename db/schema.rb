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

ActiveRecord::Schema.define(version: 2019_06_08_022611) do

  create_table "patients", force: :cascade do |t|
    t.integer "person_id"
    t.string "blood_type"
    t.boolean "insured"
    t.string "insurance_carrier"
    t.string "insurance_number"
    t.string "scholarship"
    t.boolean "studying"
    t.string "study_place"
    t.boolean "private_education"
    t.boolean "working"
    t.string "working_place"
    t.string "occupation"
    t.float "fixed_income"
    t.integer "working_family_members"
    t.string "working_hours"
    t.string "housing_type"
    t.integer "cohabitants_number"
    t.boolean "home_insurance"
    t.string "home_insurance_carrier"
    t.string "recreation_place"
    t.string "recreation_frequency"
    t.index ["person_id"], name: "index_patients_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "identification"
    t.string "name"
    t.string "last_name"
    t.string "address"
    t.string "phone_number"
    t.string "genre"
    t.date "birthday"
    t.string "birth_place"
    t.string "nationality"
    t.string "email"
    t.string "civil_status"
    t.string "religion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
