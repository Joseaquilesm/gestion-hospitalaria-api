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

ActiveRecord::Schema.define(version: 2019_06_21_022034) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.text "motive"
    t.date "appointment_date"
    t.string "hour_date"
    t.integer "doctor_id"
    t.integer "secretary_id"
    t.integer "patient_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["secretary_id"], name: "index_appointments_on_secretary_id"
  end

  create_table "clinic_histories", force: :cascade do |t|
    t.string "premorbid_personality"
    t.string "family_constellation"
    t.string "axis_1"
    t.string "axis_2"
    t.string "axis_3"
    t.string "axis_4"
    t.string "axis_5"
    t.string "additional_comment"
    t.string "initial_psychiatric_management"
    t.integer "toxic_habit_id"
    t.integer "patient_id"
    t.index ["patient_id"], name: "index_clinic_histories_on_patient_id"
    t.index ["toxic_habit_id"], name: "index_clinic_histories_on_toxic_habit_id"
  end

  create_table "medic_licenses", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medic_licenses_on_user_id"
  end

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
    t.string "religion"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.date "permission_date"
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toxic_habits", force: :cascade do |t|
    t.boolean "coffee"
    t.integer "cups_per_day"
    t.boolean "tizana"
    t.string "tizana_type"
    t.integer "tizanas_per_day"
    t.boolean "tobacco"
    t.integer "tobacco_per_day"
    t.boolean "alcohol"
    t.string "alcohol_type"
    t.integer "alcohol_per_day"
    t.boolean "other_substances"
    t.string "substances_details"
  end

  create_table "users", force: :cascade do |t|
    t.integer "person_id"
    t.integer "specialty_id"
    t.integer "role_id"
    t.integer "work_day_id"
    t.string "entry_time"
    t.string "departure_time"
    t.index ["person_id"], name: "index_users_on_person_id"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["specialty_id"], name: "index_users_on_specialty_id"
    t.index ["work_day_id"], name: "index_users_on_work_day_id"
  end

  create_table "vacations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vacations_on_user_id"
  end

  create_table "work_days", force: :cascade do |t|
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
